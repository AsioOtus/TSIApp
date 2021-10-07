import Foundation
import SwiftDate



extension Schedule {
	enum IntervalType: String, CaseIterable, Codable, Equatable {
		case day
		case week
		case month
	}
}



extension Schedule.IntervalType {
	var localizationKey: Local.Keys.ScheduleTableView {
		switch self {
		case .day: return .day
		case .week: return .week
		case .month: return .month
		}
	}
}



extension Schedule.IntervalType {
	func dateComponent (count: Int = 1) -> DateComponents {
		switch self {
		case .day: return count.days
		case .week:	return count.weeks
		case .month: return count.months
		}
	}
	
	var previous: DateRelatedType {
		switch self {
		case .day: return .yesterday
		case .week:	return .prevWeek
		case .month: return .prevMonth
		}
	}
	
	var next: DateRelatedType {
		switch self {
		case .day: return .tomorrow
		case .week:	return .nextWeek
		case .month: return .nextMonth
		}
	}
	
	var start: DateRelatedType {
		switch self {
		case .day: return .startOfDay
		case .week: return .startOfWeek
		case .month: return .startOfMonth
		}
	}
	
	var end: DateRelatedType {
		switch self {
		case .day: return .endOfDay
		case .week:	return .endOfWeek
		case .month: return .endOfMonth
		}
	}
	
	func boundDates (for date: DateInRegion) -> (DateInRegion, DateInRegion) {
		switch self {
		case .day: return (date.dateAt(.startOfDay), date.dateAt(.startOfDay))
		case .week: return (date.dateAt(.startOfWeek).dateAt(.startOfDay), date.dateAt(.endOfWeek))
		case .month: return (date.dateAt(.startOfMonth).dateAt(.startOfDay), date.dateAt(.endOfMonth))
		}
	}
	
	func boundDateTimes (for date: DateInRegion) -> (DateInRegion, DateInRegion) {
		switch self {
		case .day: return (date.dateAt(.startOfDay), date.dateAt(.endOfDay))
		case .week: return (date.dateAt(.startOfWeek).dateAt(.startOfDay), date.dateAt(.endOfWeek).dateAt(.endOfDay))
		case .month: return (date.dateAt(.startOfMonth).dateAt(.startOfDay), date.dateAt(.endOfMonth).dateAt(.endOfDay))
		}
	}
	
	func originDate (for date: DateInRegion) -> DateInRegion {
		switch self {
		case .day: return date.dateAt(.startOfDay)
		case .week: return date.dateAt(.startOfWeek).dateAt(.startOfDay)
		case .month: return date.dateAt(.startOfMonth).dateAt(.startOfDay)
		}
	}
	
	func dates (for date: DateInRegion) -> [DateInRegion] {
		let (startDate, endDate) = boundDates(for: date)
		let dates = DateInRegion.enumerateDates(from: startDate, to: endDate, increment: 1.days)
		return dates
	}
}
