protocol LocalizationKey: RawRepresentable where RawValue == String {
	static var tableName: String { get }
}

extension Local {
	struct Keys { }
}

extension Local.Keys {
	enum Common: String, LocalizationKey {
		case schedule = "Schedule"
		case settings = "Settings"
		case preferences = "Preferences"
		case reset = "Reset"
		case done = "Done"
		case cancel = "Cancel"
		case loading = "Loading"
		case retry = "Retry"
		case refresh = "Refresh"
		
		case russian = "Russian"
		case english = "English"
		case latvian = "Latvian"
		case system  = "System"
		
		
		
		static let tableName = "Common"
	}
	
	enum ScheduleTableView: String, LocalizationKey {		
		case day = "Schedule.TableView.Day"
		case week = "Schedule.TableView.Week"
		case month = "Schedule.TableView.Month"
		
		case loadingFailed = "Schedule.TableView.LoadingFailed"
		
		case noLectures = "Schedule.TableView.NoLectures"
		case withoutLectures = "Schedule.TableView.WithoutLectures"
		
		case noFilterSelected = "Schedule.TableView.NoFilterSelected"
		case filterSetInstructionStart = "Schedule.TableView.FilterSetInstruction.Start"
		case filterSetInstructionEnd = "Schedule.TableView.FilterSetInstruction.End"
		
		
		
		static let tableName = "Localization"
	}
	
	enum ScheduleSelectDateView: String, LocalizationKey {
		case title = "Schedule.SelectDateView.Title"
		case datePickerLabel = "Schedule.SelectDateView.DatePickerLabel"
		
		case today = "Schedule.SelectDateView.TodayButton"
		case tomorrow = "Schedule.SelectDateView.TomorrowButton"
		case theDayAfterTomorrow = "Schedule.SelectDateView.TheDayAfterTomorrowButton"
		
		static let tableName = "Localization"
	}
	
	enum ScheduleSettingsView: String, LocalizationKey {
		case title = "Schedule.SettingsView.Title"
		
		case filters  = "Schedule.SettingsView.Filters"
		case enterFilter   = "Schedule.SettingsView.EnterFilter"
		
		case group    = "Schedule.SettingsView.Group"
		case lecturer = "Schedule.SettingsView.Lecturer"
		case room     = "Schedule.SettingsView.Room"
		
		case filterValuesSetsLoadingError = "Schedule.SettingsView.LoadingError"
		case selectedGroupIsNotExist = "Schedule.SettingsView.SelectedGroupIsNotExist"
		case selectedLecturerIsNotExist = "Schedule.SettingsView.SelectedLecturerIsNotExist"
		case selectedRoomIsNotExist = "Schedule.SettingsView.SelectedRoomIsNotExist"
		
		case emptyLecturesDisplaying = "Schedule.SettingsView.EmptyLecturesDisplaying"
		
		case noneLectures = "Schedule.SettingsView.EmptyLecturesDisplaying.NoneLectures"
		case untilNonEmptyLecture = "Schedule.SettingsView.EmptyLecturesDisplaying.UntilNonEmptyLecture"
		case allLectures = "Schedule.SettingsView.EmptyLecturesDisplaying.AllLectures"
		
		
		
		static let tableName = "Localization"
	}
	
	enum PreferencesView: String, LocalizationKey {		
		case title = "Preferences.PreferencesView.Title"
		
		case language = "Preferences.PreferencesView.Language"
		case selectLanguage = "Preferences.PreferencesView.SelectLanguage"
		case about = "Preferences.PreferencesView.About"
		
		
		
		static let tableName = "Localization"
	}
	
	enum Errors {
		enum Common: String, LocalizationKey {
			case unexpectedError = "Errors.Unexpected"
			case internalError = "Errors.Internal"
			
			
			
			static let tableName = "Errors"
		}
		
		enum Network: String, LocalizationKey {
			case loadingError = "Errors.Network.Loading"
			case internalNetworkError = "Errors.Network.Internal"
			case noConnectionHeader = "Errors.Network.NoConnection.Header"
			case noConnectionText = "Errors.Network.NoConnection.Text"
			
			
			
			static let tableName = "Errors"
		}
	}
}

extension Local {
	static subscript <Key: LocalizationKey> (_ key: Key) -> String {
		shared.localize(key.rawValue, Key.tableName)
	}
	
	static subscript (_ key: Keys.Common) -> String {
		shared.localize(key.rawValue, Keys.Common.tableName)
	}
	
	static subscript (common key: Keys.Common) -> String {
		shared.localize(key.rawValue, Keys.Common.tableName)
	}
	
	static subscript (_ key: Keys.ScheduleSelectDateView) -> String {
		shared.localize(key.rawValue, Keys.ScheduleSelectDateView.tableName)
	}
	
	static subscript (selectDate key: Keys.ScheduleSelectDateView) -> String {
		shared.localize(key.rawValue, Keys.ScheduleSelectDateView.tableName)
	}
	
	static subscript (_ key: Keys.ScheduleTableView) -> String {
		shared.localize(key.rawValue, Keys.ScheduleTableView.tableName)
	}
	
	static subscript (table key: Keys.ScheduleTableView) -> String {
		shared.localize(key.rawValue, Keys.ScheduleTableView.tableName)
	}
	
	static subscript (_ key: Keys.ScheduleSettingsView) -> String {
		shared.localize(key.rawValue, Keys.ScheduleSettingsView.tableName)
	}
	
	static subscript (settings key: Keys.ScheduleSettingsView) -> String {
		shared.localize(key.rawValue, Keys.ScheduleSettingsView.tableName)
	}
	
	static subscript (_ key: Keys.PreferencesView) -> String {
		shared.localize(key.rawValue, Keys.PreferencesView.tableName)
	}
	
	static subscript (preferences key: Keys.PreferencesView) -> String {
		shared.localize(key.rawValue, Keys.PreferencesView.tableName)
	}
	
	static subscript (_ key: Keys.Errors.Common) -> String {
		shared.localize(key.rawValue, Keys.Errors.Common.tableName)
	}
	
	static subscript (commonError key: Keys.Errors.Common) -> String {
		shared.localize(key.rawValue, Keys.Errors.Common.tableName)
	}
	
	static subscript (_ key: Keys.Errors.Network) -> String {
		shared.localize(key.rawValue, Keys.Errors.Network.tableName)
	}
	
	static subscript (netowrkError key: Keys.Errors.Network) -> String {
		shared.localize(key.rawValue, Keys.Errors.Network.tableName)
	}
}
