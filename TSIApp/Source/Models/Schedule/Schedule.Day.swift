import SwiftDate

extension Schedule {
	enum Day {
		case plain(Info)
		case empty(startDate: DateInRegion, endDate: DateInRegion)
		
		var date: DateInRegion {
			switch self {
			case .plain(let info):
				return info.date
			case .empty(let startDate, _):
				return startDate
			}
		}
	}
}

extension Schedule.Day {
	struct Info {
		let date: DateInRegion
		var events: [Schedule.Event]
		
		init (_ date: DateInRegion, _ events: [Schedule.Event] = []) {
			self.date = date
			self.events = events
		}
	}
}
