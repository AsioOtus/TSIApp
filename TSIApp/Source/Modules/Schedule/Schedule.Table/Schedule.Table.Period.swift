import SwiftUI
import SwiftDate
import BaseNetworkUtil
import Combine



extension Schedule.Table {
	struct Period {
		enum LoadingState {
			case notInitialized
			case loading
			case loaded
			case failed(Error)
		}
		
		private var cancellables = Set<AnyCancellable>()
		
		let originDate: DateInRegion
		let intervalType: Schedule.IntervalType
		
		var loadingState: LoadingState
		lazy var days: [Day] = {
			intervalType.dates(originDate).map { Schedule.Table.Day($0) }
		}()
		
		init (_ originDate: DateInRegion, _ intervalType: Schedule.IntervalType, _ days: [Day]? = nil) {
			let originDate = intervalType.originDate(originDate)
			
			self.originDate = originDate
			self.intervalType = intervalType
			
			if let days = days {
				loadingState = .loaded
				self.days = days
			} else {
				loadingState = .notInitialized
			}
		}
	}
}



extension Schedule.Table.Period {
//	mutating func load () {
//		loadingState = .loading
//		
//		Requests.TSI.Controller.shared.send(Requests.TSI.GetLocalizedEvents.MonthDelegate(date: originDate))
//			.sink(
//				receiveCompletion: { completion in
//					if case .failure(let error) = completion {
//						self.loadingState = .failed(error)
//					}
//				},
//				receiveValue: { rawEvents in
//					let displayEvents = rawEvents.map(self.rawToDisplay)
//					let groupedDisplayEvents = Dictionary(grouping: displayEvents, by: { $0.raw.date.dateAt(.startOfDay) })
//					
//					for dayDisplayEvents in groupedDisplayEvents where !dayDisplayEvents.value.isEmpty {
//						guard let index = days.firstIndex(where: { $0.date == dayDisplayEvents.key }) else { continue }
//						days[index].addEvents(dayDisplayEvents.value)
//					}
//					
//					loadingState = .loaded
//				}
//			)
//			.store(in: &cancellables)
//	}
//	
//	func rawToDisplay (_ rawEvent: Schedule.Event.Raw) -> Schedule.Event.Display {
//		var displayEvent = Schedule.Event.Display(
//			raw: rawEvent,
//			groups: .notInitialized,
//			lecturer: .notInitialized,
//			rooms: .notInitialized
//		)
//		
//		displayEvent.fill(from: App.State.current.scheduleFilterValuesSets)
//		
//		return displayEvent
//	}
}



extension Schedule.Table.Period: Hashable {
	static func == (lhs: Schedule.Table.Period, rhs: Schedule.Table.Period) -> Bool {
		lhs.originDate == rhs.originDate
	}
	
	var hashValue: Int {
		originDate.hashValue
	}
}
