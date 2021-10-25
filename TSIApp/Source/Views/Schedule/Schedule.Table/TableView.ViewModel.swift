import SwiftUI
import SwiftUIPager
import Combine
import SwiftDate
import DequeModule
import LoggingUtil

extension Schedule.Table.TableView {
	class ViewModel: ObservableObject {
		private var cancellables = Set<AnyCancellable>()
		private let logger = StandardLogger(Logging.centralHandler)
		
		@Published var appState: App.State
		
		static let treshold = 2
		static let bufferSize = 3
		static let newItemsCount = 1
		
		@Published var periodViewModels: Deque<Schedule.Table.PeriodView.ViewModel> = []
		@Published var page: Page = .withIndex(bufferSize)
		
		init (appState: App.State) {
			self.appState = appState
			
			self.periodViewModels = Self.newPeriodVms(appState.day, appState.intervalType, appState)
			
			appState.$intervalType
				.dropFirst()
				.sink { intervalType in
					self.page = .withIndex(Self.bufferSize)
					self.periodViewModels = Self.newPeriodVms(appState.day, intervalType, appState)
				}
				.store(in: &cancellables)
			
			appState.dateTimeUpdated
//				.dropFirst()
				.sink { dateTime in
					self.page = .withIndex(Self.bufferSize)
					self.periodViewModels = Self.newPeriodVms(appState.dateTime.dateAt(.startOfDay), appState.intervalType, appState)
				}
				.store(in: &cancellables)
		}
		
		func pageChanged (_ index: Int) {
			if let periodVm = periodViewModels[safe: index] {
				appState.dateTime = periodVm.period.startDate.dateAt(appState.intervalType.start)
				logger.info("Current period: \(periodVm.period.startDate.toFormat("dd.MM.yyy")) - \(periodVm.period.endDate.toFormat("dd.MM.yyy"))")
			}
			
			if index <= Self.treshold, let firstPeriodVM = periodViewModels.first {
				
				let newPeriodStartDate = firstPeriodVM.period.startDate.dateAt(appState.intervalType.previous)
				let newPeriod = Schedule.Period(newPeriodStartDate, newPeriodStartDate.dateAt(appState.intervalType.end))
				let newPeriodVM = Schedule.Table.PeriodView.ViewModel(appState: appState, period: newPeriod)
				
				periodViewModels.prepend(newPeriodVM)
				periodViewModels.removeLast()
				
				page.index += Self.newItemsCount
			} else if index >= periodViewModels.count - Self.treshold, let lastPeriodVM = periodViewModels.last {
				
				
				let newPeriodStartDate = lastPeriodVM.period.startDate.dateAt(appState.intervalType.next)
				let newPeriod = Schedule.Period(newPeriodStartDate, newPeriodStartDate.dateAt(appState.intervalType.end))
				let newPeriodVM = Schedule.Table.PeriodView.ViewModel(appState: appState, period: newPeriod)
				
				periodViewModels.append(newPeriodVM)
				periodViewModels.removeFirst()
				
				page.index -= Self.newItemsCount
			}
		}
		
		func moveToday () {
			appState.dateTime = DateInRegion()
//			self.periodViewModels = Self.newChilds(DateInRegion().dateAt(.startOfDay), appState)
		}
		
		static func newPeriodVms (_ date: DateInRegion, _ intervalType: Schedule.IntervalType, _ appState: App.State) -> Deque<Schedule.Table.PeriodView.ViewModel> {
			let startDate = (date - intervalType.dateComponent(count: Self.bufferSize)).dateAt(intervalType.start).dateAt(.startOfDay)
			let endDate = (date + intervalType.dateComponent(count: Self.bufferSize)).dateAt(intervalType.end).dateAt(.endOfDay)
			
			let dates = DateInRegion.enumerateDates(from: startDate, to: endDate, increment: intervalType.dateComponent())
			let periods = dates.map{ Schedule.Period($0, $0.dateAt(intervalType.end)) }.map{ Schedule.Table.PeriodView.ViewModel(appState: appState, period: $0) }
			
			return Deque(periods)
		}
	}
}
