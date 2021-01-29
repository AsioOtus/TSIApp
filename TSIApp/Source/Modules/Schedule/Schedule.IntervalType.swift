import Foundation
import SwiftDate



extension Schedule {
	enum IntervalType: Int, CaseIterable, Codable, Equatable {
		case day
		case week
		case month
	}
}



extension Schedule.IntervalType {
	var localizationKey: Local.Keys.ScheduleTableView {
		let key: Local.Keys.ScheduleTableView
		
		switch self {
		case .day:
			key = .day
		case .week:
			key = .week
		case .month:
			key = .month
		}
		
		return key
	}
}



extension Schedule.IntervalType {
	func dateComponent (count: Int = 1) -> DateComponents {
		let dateComponent: DateComponents
		
		switch self {
		case .day:
			dateComponent = count.days
		case .week:
			dateComponent = count.weeks
		case .month:
			dateComponent = count.months
		}
		
		return dateComponent
	}
	
	func boundDates (for date: DateInRegion) -> (DateInRegion, DateInRegion) {
		let boundDates: (DateInRegion, DateInRegion)
		
		switch self {
		case .day:
			boundDates = (date.dateAt(.startOfDay), date.dateAt(.endOfDay))
		case .week:
			boundDates = (date.dateAt(.startOfWeek).dateAt(.startOfDay), date.dateAt(.endOfWeek))
		case .month:
			boundDates = (date.dateAt(.startOfMonth).dateAt(.startOfDay), date.dateAt(.endOfMonth))
		}
		
		return boundDates
	}
	
	func originDate (_ date: DateInRegion) -> DateInRegion {
		let originDate: DateInRegion
		
		switch self {
		case .day:
			originDate = date.dateAt(.startOfDay)
		case .week:
			originDate = date.dateAt(.startOfWeek).dateAt(.startOfDay)
		case .month:
			originDate = date.dateAt(.startOfMonth).dateAt(.startOfDay)
		}
		
		return originDate
	}
	
	func dates (_ date: DateInRegion) -> [DateInRegion] {
		let (startDate, endDate) = boundDates(for: date)
		let dates = DateInRegion.enumerateDates(from: startDate, to: endDate, increment: 1.days)
		return dates
	}
}
