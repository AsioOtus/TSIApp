import SwiftUI
import UserDefaultsUtil
import SwiftDate
import Combine

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
		
		@Published var scheduleFilterValuesSets: LoadingState<AnyCancellable, Schedule.FilterValuesSets> = .notInitialized
		
		@Published var group: SelectionModel = UserDefaults.group.loadOrDefault() {
			didSet { UserDefaults.group.save(group) }
		}
		@Published var lecturer: SelectionModel = UserDefaults.lecturer.loadOrDefault() {
			didSet { UserDefaults.lecturer.save(lecturer) }
		}
		@Published var room: SelectionModel = UserDefaults.room.loadOrDefault() {
			didSet { UserDefaults.room.save(room) }
		}
		
		let scheduleFilterValuesUpdated = PassthroughSubject<Void, Never>()
		let dateTimeUpdated = PassthroughSubject<Void, Never>()
		
		@Published var language: FrontendLanguage = UserDefaults.language.loadOrDefault() {
			didSet {
				UserDefaults.language.save(language)
				Local.shared.updateCurrentLanguage(language)
			}
		}
		
		var colorScheme: AppColorScheme = StandardColorScheme()
	}
}



extension App.State {
	var day: DateInRegion { dateTime.dateAt(.startOfDay) }
}
