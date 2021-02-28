import SwiftUI
import UserDefaultsUtil
import SwiftDate



extension App {
	class State: ObservableObject {
		static var current = State()
		private init () { }
		
		@Published var dateTime = UserDefaults.dateTime.loadOrDefault() {
			didSet { UserDefaults.dateTime.save(dateTime) }
		}
		
		@Published var intervalType = UserDefaults.intervalType.loadOrDefault() {
			didSet { UserDefaults.intervalType.save(intervalType) }
		}
		
		@Published var scheduleFilterValuesSets: LoadingState<Schedule.FilterValuesSets> = .notInitialized
		
		@Published var group: SelectionModel = UserDefaults.group.loadOrDefault() {
			didSet { UserDefaults.group.save(group) }
		}
		@Published var lecturer: SelectionModel = UserDefaults.lecturer.loadOrDefault() {
			didSet { UserDefaults.lecturer.save(lecturer) }
		}
		@Published var room: SelectionModel = UserDefaults.room.loadOrDefault() {
			didSet { UserDefaults.room.save(room) }
		}
		
		@Published var language: FrontendLanguage = UserDefaults.language.loadOrDefault() {
			didSet {
				UserDefaults.language.save(language)
				Local.shared.updateCurrentLanguage(language)
			}
		}
		
		var colorScheme: AppColorScheme = ColorScheme()
	}
}



extension App.State {
	var day: DateInRegion { dateTime.dateAt(.startOfDay) }
	
	var currentPeriod: (from: DateInRegion, to: DateInRegion) {
		(dateTime.dateAt(.startOfMonth).dateAt(.startOfDay), day.dateAt(.endOfMonth).dateAt(.endOfDay))
	}
	
	var boundDates: (DateInRegion, DateInRegion) {
		intervalType.boundDates(for: dateTime)
	}
	
	var scheduleFilter: Schedule.Filter {
		//		let selectedDate = UserDefaults.day.loadOrDefault()
		let a = DateInRegion().dateAt(.endOfDay)
		
		var dateComponents = DateComponents()
		dateComponents.year = 2020
		dateComponents.month = 9
		dateComponents.timeZone = TimeZone(abbreviation: "UTC")
		let selectedDate = Calendar.current.date(from: dateComponents)!
		
		let schduleFilter = Schedule.Filter(
			from: Int(selectedDate.firstMonthDay.dayStart.timeIntervalSince1970),
			to: Int(selectedDate.lastMonthDay.dayEnd.timeIntervalSince1970),
			group: group,
			lecturer: lecturer,
			room: room,
			language: language
		)
		
		return schduleFilter
	}
}
