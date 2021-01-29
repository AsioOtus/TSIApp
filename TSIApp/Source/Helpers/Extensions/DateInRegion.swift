import Foundation
import SwiftDate

extension DateInRegion {
	var dayTime: TimeInterval {
		let dayTime = (minute.minutes + hour.hours).timeInterval
		return dayTime
	}
}
