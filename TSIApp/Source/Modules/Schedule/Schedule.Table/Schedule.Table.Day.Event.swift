import Foundation
import SwiftDate



extension Schedule.Table.Day.Event {
	enum Order: CaseIterable {
		case event01
		case event02
		case event03
		case event04
		case event05
		case event06
		case event07
		case event08
		case event09
		
		static let event01StartTime = (08.hours + 45.minutes).timeInterval
		static let event02StartTime = (10.hours + 30.minutes).timeInterval
		static let event03StartTime = (12.hours + 15.minutes).timeInterval
		
		static let event04StartTime = (14.hours + 00.minutes).timeInterval
		static let event05StartTime = (15.hours + 45.minutes).timeInterval
		static let event06StartTime = (17.hours + 30.minutes).timeInterval
		
		static let event07StartTime = (19.hours + 15.minutes).timeInterval
		static let event08StartTime = (21.hours + 00.minutes).timeInterval
		static let event09StartTime = (22.hours + 45.minutes).timeInterval
		
		var index: Int {
			let index: Int
			
			switch self {
			case .event01:
				index = 0
			case .event02:
				index = 1
			case .event03:
				index = 2
			case .event04:
				index = 3
			case .event05:
				index = 4
			case .event06:
				index = 5
			case .event07:
				index = 6
			case .event08:
				index = 7
			case .event09:
				index = 8
			}
			
			return index
		}
		
		var order: Int { index + 1 }
		
		var startTime: TimeInterval {
			let startTime: TimeInterval
			
			switch self {
			case .event01:
				startTime = Self.event01StartTime
			case .event02:
				startTime = Self.event02StartTime
			case .event03:
				startTime = Self.event03StartTime
			case .event04:
				startTime = Self.event04StartTime
			case .event05:
				startTime = Self.event05StartTime
			case .event06:
				startTime = Self.event06StartTime
			case .event07:
				startTime = Self.event07StartTime
			case .event08:
				startTime = Self.event08StartTime
			case .event09:
				startTime = Self.event09StartTime
			}
			
			return startTime
		}
		
		static var allEvents: [Schedule.Table.Day.Event] {
			allCases.map{ .init(order: $0, displayEvent: .notInitialized) }
		}
		
		var endTime: TimeInterval {
			let endTime = startTime + Schedule.Table.Day.Event.duration
			return endTime
		}
		
		func isInside (_ time: TimeInterval) -> Bool {
			time >= startTime && time <= endTime
		}
	}
}



extension Schedule.Table.Day {
	struct Event {
		static let duration = 90.minutes.timeInterval
		
		let order: Order
		
		var displayEvent: LoadingState<Schedule.Event.Display?>
	}
}
