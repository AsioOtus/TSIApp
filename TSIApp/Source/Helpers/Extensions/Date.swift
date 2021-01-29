import Foundation

extension Date {
	static let TATimeFormat = "HH:mm"
	static let TADateFormat = "dd.MM"
	
	static let timeFormatter: DateFormatter = {
		var formatter = DateFormatter()
		formatter.dateFormat = TATimeFormat
		return formatter
	}()
	
	static let dateFormatter: DateFormatter = {
		var formatter = DateFormatter()
		formatter.dateFormat = TADateFormat
		return formatter
	}()
	
	
	
	var dayStart: Date {
		let startOfDay = Calendar.project.startOfDay(for: self)
		return startOfDay
	}
	
	var dayEnd: Date {
		var components = DateComponents()
		components.day = 1
		components.nanosecond = -1
		
		return Calendar.project.date(byAdding: components, to: self.dayStart)!
	}
	
	var firstWeekDay: Date {
		let components = Calendar.project.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
		let lastSunday = Calendar.project.date(from: components)!
		let firstWeekDay = Calendar.project.date(byAdding: .day, value: 1, to: lastSunday)!
		return firstWeekDay
	}
	
	var lastWeekDay: Date {
		var components = DateComponents()
		components.weekOfYear = 1
		components.day = -1
		
		let lastWeekDay = Calendar.project.date(byAdding: components, to: firstWeekDay)!
		return lastWeekDay
	}
	
	var firstMonthDay: Date {
		let components = Calendar.project.dateComponents([.year, .month], from: self)
		let firstMonthDay = Calendar.project.date(from: components)!
		return firstMonthDay
	}
	
	var lastMonthDay: Date {
		var components = DateComponents()
		components.month = 1
		components.day = -1
		
		let lastMonthDay = Calendar.project.date(byAdding: components, to: firstMonthDay)!
		return lastMonthDay
	}
	
	var dayTime: TimeInterval {
		let components = Calendar.project.dateComponents([.hour, .minute], from: self)
		let date = components.date!
		let timeInterval = date.timeIntervalSince1970
		return timeInterval
	}
	
	var timeString: String { Self.timeFormatter.string(from: self) }
	
	var dateString: String { Self.dateFormatter.string(from: self) }
	
	init? (hour: Int, minute: Int) {
		var dateComponents = DateComponents()
		dateComponents.hour = hour
		dateComponents.minute = minute
		
		guard let date = dateComponents.date else { return nil }
		self = date
	}
}
