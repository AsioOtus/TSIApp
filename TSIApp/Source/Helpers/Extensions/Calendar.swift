import Foundation

extension Calendar {
	static let project: Calendar = {
		var calendar = Calendar.current
		calendar.timeZone = TimeZone(identifier: "UTC")!
		return calendar
	}()
}
