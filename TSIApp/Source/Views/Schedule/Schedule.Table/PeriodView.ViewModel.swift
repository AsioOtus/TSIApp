import SwiftUI
import BaseNetworkUtil
import NetworkUtil
import SwiftDate
import Combine
import OrderedCollections
import LoggingUtil
import CombineExtensions

extension Schedule.Table.PeriodView {
	class ViewModel: ObservableObject {
		private var cancellables = Set<AnyCancellable>()
		private let networkController: NetworkController = NetworkController()
			.logHandler(baseNetworkUtilLogger)
		
		@Published var appState: App.State
		@Published var period: Schedule.Period
		@Published var days: LoadingState<Void, [Schedule.Day]>
		
		@Published var isLoadingIndicatorVisible: Bool = false
		
		init (appState: App.State, period: Schedule.Period) {
			self.appState = appState
			self.period = period
			
			self.days = .notInitialized
			
			refresh()
			
			appState.scheduleFilterValuesUpdated
				.sink {
					self.refresh()
				}
				.store(in: &cancellables)
			
			appState.$scheduleFilterValuesSets
				.dropFirst()
				.sink { scheduleFilterValuesSets in
					self.refreshEventsDisplayInfo(scheduleFilterValuesSets)
				}
				.store(in: &cancellables)
			
			appState.$language
				.dropFirst()
				.sink { _ in
					DispatchQueue.main.after(.milliseconds(500)) { self.refresh() }
				}
				.store(in: &cancellables)
		}
		
		func refresh () {
			guard appState.group != .empty || appState.lecturer != .empty || appState.room != .empty else { return }
			
			self.days = .loading(())
			
			networkController
				.send(TSI.Requests.GetLocalizedEvents.Delegate(fromDate: period.startDate, toDate: period.endDate), label: "GetLocalizedEvents")
				.subscribe(on: DispatchQueue.global(qos: .background))
				.deferredDelay(
					after: 0.2,
					for: 2,
					scheduler: DispatchQueue.global(qos: .background)
				)
				.sink(
					receiveCompletion: { completion in
						if case .failure(let error) = completion {
							DispatchQueue.main.async {
								self.days = .failed(error)
							}
						}
					},
					receiveValue: { eventsInfo in
						let dates = DateInRegion.enumerateDates(from: self.period.startDate, to: self.period.endDate, increment: 1.days)
						let groupedEventsDictionary = Dictionary(grouping: eventsInfo, by: { $0.date.dateAt(.startOfDay) })
						
						var days = [Schedule.Day]()
						var emptyIntervalStartDate: DateInRegion?
						
						for date in dates {
							if let dayEvents = groupedEventsDictionary.first(where: { $0.key.dateAt(.startOfDay) == date.dateAt(.startOfDay) }) {
								if let startDate = emptyIntervalStartDate {
									days.append(.empty(startDate: startDate, endDate: date - 1.days))
									emptyIntervalStartDate = nil
								}
								
								var events = [Schedule.Event]()
								var currentStartTime = Schedule.Event.dayStartTime
								
								for dayEvent in dayEvents.value {
									if (dayEvent.date.dayTime - currentStartTime) > 30.minutes.timeInterval {
										events.append(.init(startTime: currentStartTime, endTime: dayEvent.date.dayTime))
									}
									
									events.append(.init(info: dayEvent))
									currentStartTime = dayEvent.endTime
								}
								
								days.append(.plain(.init(date, events)))
							} else {
								if emptyIntervalStartDate == nil {
									emptyIntervalStartDate = date
								}
							}
						}
						
						if let startDate = emptyIntervalStartDate, let lastDate = dates.last {
							days.append(.empty(startDate: startDate, endDate: lastDate))
							emptyIntervalStartDate = nil
						}
						
						DispatchQueue.main.async {
							self.isLoadingIndicatorVisible = false
							self.days = .loaded(days)
							
							self.refreshEventsDisplayInfo(self.appState.scheduleFilterValuesSets)
						}
					}
				)
				.store(in: &cancellables)
			
			DispatchQueue.main.async {
				self.isLoadingIndicatorVisible = true
			}
		}
		
		func refreshEventsDisplayInfo (_ scheduleFilterValuesSets: LoadingState<AnyCancellable, Schedule.FilterValuesSets>) {
			guard case .loaded(var days) = days else { return }
			
			switch scheduleFilterValuesSets {
			case .notInitialized:
				days = days.map { day in
					if case var .plain(info) = day {
						info.events = info.events.map { event in
							var event = event
							event.update(displayInfo: .notInitialized)
							return event
						}
						
						return .plain(info)
					} else {
						return day
					}
				}
				
			case .loading(_):
				days = days.map { day in
					if case var .plain(info) = day {
						info.events = info.events.map { event in
							var event = event
							event.update(displayInfo: .loading(()))
							return event
						}
						
						return .plain(info)
					} else {
						return day
					}
				}
				
			case .loaded(let values):
				days = days.map { day in
					if case var .plain(dayInfo) = day {
						dayInfo.events = dayInfo.events.map { event in
							var event = event
							
							if case let .plain(eventInfo) = event {
								let groups: [Schedule.Event.Info.Display.ItemState] = eventInfo.groups.map { group in
									if let foundGroup = values.groups.first(where: { $0.key == group }) {
										return .value(foundGroup)
									} else {
										return .notFound(group)
									}
								}
								
								let lecturer: Schedule.Event.Info.Display.ItemState
								if let foundLecturer = values.lecturers.first(where: { $0.key == eventInfo.lecturer }) {
									lecturer = .value(foundLecturer)
								} else {
									lecturer = .notFound(eventInfo.lecturer)
								}
								
								let rooms: [Schedule.Event.Info.Display.ItemState] = eventInfo.rooms.map { room in
									if let foundRoom = values.rooms.first(where: { $0.key == room }) {
										return .value(foundRoom)
									} else {
										return .notFound(room)
									}
								}
								
								let displayInfo = Schedule.Event.Info.Display(groups: groups, lecturer: lecturer, rooms: rooms)
								
								event.update(displayInfo: .loaded(displayInfo))
							}
							
							return event
						}
						
						return .plain(dayInfo)
					} else {
						return day
					}
				}
				
			case .failed(let error):
				days = days.map { day in
					if case var .plain(info) = day {
						info.events = info.events.map { event in
							var event = event
							event.update(displayInfo: .failed(error))
							return event
						}
						
						return .plain(info)
					} else {
						return day
					}
				}
			}
			
			DispatchQueue.main.async {
				self.days = .loaded(days)
			}
		}
	}
}

extension Schedule.Table.PeriodView.ViewModel: Equatable {
	static func == (lhs: Schedule.Table.PeriodView.ViewModel, rhs: Schedule.Table.PeriodView.ViewModel) -> Bool {
		lhs.period == rhs.period
	}
}
