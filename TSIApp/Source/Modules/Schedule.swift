import SwiftDate

struct Schedule { }

extension Schedule {
	static var lastEarlyDate: DateInRegion {
		DateInRegion() - 10.years
	}
}
