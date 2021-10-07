import SwiftUI
import SwiftDate
import BaseNetworkUtil
import Combine

extension Schedule {
	struct Period {
		let startDate: DateInRegion
		let endDate: DateInRegion
		
		init (_ startDate: DateInRegion, _ endDate: DateInRegion) {
			self.startDate = startDate
			self.endDate = endDate
		}
	}
}

extension Schedule.Period: Hashable {
	static func == (lhs: Schedule.Period, rhs: Schedule.Period) -> Bool {
		lhs.startDate == rhs.startDate && lhs.endDate == rhs.endDate
	}
	
	func hash (into hasher: inout Hasher) {
		hasher.combine(startDate)
		hasher.combine(endDate)
	}
}
