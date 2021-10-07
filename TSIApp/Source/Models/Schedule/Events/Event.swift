import Foundation
import SwiftDate

extension Schedule {
	enum Event {
		case empty(startTime: TimeInterval, endTime: TimeInterval)
		case plain(info: Info)
		
		static let dayStartTime = (8.hours + 45.minutes).timeInterval
		
		var startTime: TimeInterval {
			switch self {
			case .empty(let startTime, _):
				return startTime
			case .plain(let info):
				return info.date.dayTime
			}
		}
		
		var endTime: TimeInterval {
			switch self {
			case .empty(_, let endTime):
				return endTime
			case .plain(let info):
				return info.endTime
			}
		}
		
		var duration: TimeInterval {
			switch self {
			case .empty(let startTime, let endTime):
				return endTime - startTime
			case .plain(let info):
				return info.endTime
			}
		}
		
		init (startTime: TimeInterval, endTime: TimeInterval) {
			self = .empty(startTime: startTime, endTime: endTime)
		}
		
		init (info: Info) {
			self = .plain(info: info)
		}
		
		mutating func update (displayInfo: LoadingState<Void, Info.Display>) {
			switch self {
			case .empty: break
			case .plain(var info):
				info.display = displayInfo
				self = .plain(info: info)
			}
		}
	}
}

extension Schedule.Event {
	struct Info {
		static let duration = 90.minutes.timeInterval
		
		let date: DateInRegion
		let groups: [String]
		let lecturer: String
		let rooms: [String]
		let name: String
		let comment: String
		let `class`: Class?
		
		var display: LoadingState<Void, Display> = .notInitialized
		
		var endTime: TimeInterval {	date.dayTime + Self.duration }
	}
}

extension Schedule.Event.Info {
	struct Display: Hashable {		
		enum ItemState: Identifiable, Hashable {
			var id: String {
				switch self {
				case .value(let model):
					return model.key
				case .notFound(let key):
					return key
				}
			}
			
			case value(SelectionModel)
			case notFound(String)
		}
		
		let groups: [ItemState]
		let lecturer: ItemState?
		let rooms: [ItemState]
	}
}
