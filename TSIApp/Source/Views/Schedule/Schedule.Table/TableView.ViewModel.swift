import SwiftUI
import Combine
import SwiftDate
import BaseNetworkUtil
import NetworkUtil
import LoggingUtil



extension Schedule.Table.TableView {
	class ViewModel: ObservableObject {
		private var cancellables = Set<AnyCancellable>()
		
		private let cachedPeriodsCount = 2
		private let pagesType = Schedule.IntervalType.month
		
		@Published var currentPeriodIndex = 2
		@Published var pages: [Schedule.Table.Period] = [] {
			didSet {
				for page in pages {
					if case .notInitialized = page.loadingState {
//						load(month)
					}
				}
			}
		}
		
		
		
		func updatePages (_ direction: Double) {
			withAnimation {
				if direction > 0 && currentPeriodIndex >= currentPeriods.count - 3 {
					let newPeriod = Schedule.Table.Period(pages.last!.originDate + 1.months, App.State.current.intervalType)
					pages = pages + [newPeriod]
					pages.removeFirst()
				}
				
				if direction < 0 && currentPeriodIndex <= 2 {
					pages = [Schedule.Table.Period(pages.last!.originDate - 1.months, App.State.current.intervalType)] + pages
					pages.removeLast()
				}
			}
		}
		
		func updateCurrentPeriod (_ newCurrentPeriodIndex: Int) {
			App.State.current.dateTime = self.currentPeriods[newCurrentPeriodIndex].originDate
		}
		
		var startPagesOriginDates: [DateInRegion] {
			let periodOriginDates =
				(1...cachedPeriodsCount).map{ App.State.current.day - App.State.current.intervalType.dateComponent(count: $0) }.reversed()
				+
				[App.State.current.dateTime]
				+
				(1...cachedPeriodsCount).map{ App.State.current.day + App.State.current.intervalType.dateComponent(count: $0) }
			
			return periodOriginDates
		}
		
//		@Published var currentPeriod: Schedule.Table.Period {
//			didSet {
//				App.State.current.dateTime = self.currentPeriod.originDate
//			}
//		}
		
		var currentDates: [DateInRegion] {
			let currentPeriodDate = App.State.current.day
			let previousPeriodDate = currentPeriodDate - App.State.current.intervalType.dateComponent()
			let nextPeriodDate = currentPeriodDate + App.State.current.intervalType.dateComponent()
			
			return [previousPeriodDate, currentPeriodDate, nextPeriodDate]
		}
		
		var currentPeriods: [Schedule.Table.Period] {
			let currentPeriods = currentDates.map { Schedule.Table.Period($0, App.State.current.intervalType) }
			return currentPeriods
		}
		
//		var dates: [[DateInRegion]] {
//			let dates: [[DateInRegion]] = periodOriginDates.map{ periodOriginDate in
//				let (startDate, endDate) = App.State.current.intervalType.boundDates(for: periodOriginDate)
//				let dates = DateInRegion.enumerateDates(from: startDate, to: endDate, increment: 1.days)
//				return dates
//			}
//
//			return dates
//		}
		
		init () {
			App.State.current.$scheduleFilterValuesSets.sink { aa in
				guard case .loaded(let aa) = aa else { return }

				for i in self.pages.indices {
					for ii in self.pages[i].days.indices {
						for iii in self.pages[i].days[ii].events.indices {
							if case .loaded(var displayEvent) = self.pages[i].days[ii].events[iii].displayEvent {
								displayEvent?.fill(from: .loaded(aa))
								self.pages[i].days[ii].events[iii].displayEvent = .loaded(displayEvent)
							}
						}
					}
				}
			}
			.store(in: &cancellables)
			
			pages.append(contentsOf: startPagesOriginDates.map { Schedule.Table.Period($0, pagesType) })
		}
		
		func updateMonth (_ predicate: @escaping (Schedule.Table.Period) -> Bool, _ update: @escaping (inout Schedule.Table.Period) -> Void) {
			DispatchQueue.main.async {
				if let monthIndex = self.pages.firstIndex(where: predicate) {
					update(&self.pages[monthIndex])
				}
			}
		}
		
		func load (_ period: Schedule.Table.Period) {
			self.updateMonth({ $0.originDate == period.originDate }) { $0.loadingState = .loading }
			
			Controllers.Serial().send(TSI.Requests.GetLocalizedEvents.MonthDelegate(date: period.originDate))
				.sink(
					receiveCompletion: { completion in
						if case .failure(let error) = completion {
							self.updateMonth({ $0.originDate == period.originDate }) { $0.loadingState = .failed(error) }
						}
					},
					receiveValue: { rawEvents in
						globalLogger.notice("rawEvents received")
						
						let displayEvents = rawEvents.map(self.rawToDisplay)
						let groupedDisplayEvents = Dictionary(grouping: displayEvents, by: { $0.raw.date.dateAt(.startOfDay) })
						
						self.updateMonth({ $0.originDate == period.originDate }) {
							for dayDisplayEvents in groupedDisplayEvents where !dayDisplayEvents.value.isEmpty {
//								guard let index = period.days.firstIndex(where: { $0.date == dayDisplayEvents.key }) else { continue }
//								$0.days[index].addEvents(dayDisplayEvents.value)
							}
							
							$0.loadingState = .loaded
						}
					}
				)
				.store(in: &cancellables)
		}
	}
}



private extension Schedule.Table.TableView.ViewModel {
	func rawToDisplay (_ rawEvent: Schedule.Event.Raw) -> Schedule.Event.Display {
		var displayEvent = Schedule.Event.Display(
			raw: rawEvent,
			groups: .notInitialized,
			lecturer: .notInitialized,
			rooms: .notInitialized
		)
		
		displayEvent.fill(from: App.State.current.scheduleFilterValuesSets)
		
		return displayEvent
	}
}
