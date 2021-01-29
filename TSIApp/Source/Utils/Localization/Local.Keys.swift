extension Local {
	struct Keys { }
}



extension Local.Keys {
	enum Common: String {
		case schedule = "Schedule"
		case settings = "Settings"
		case preferences = "Preferences"
		case reset = "Reset"
		case done = "Done"
		case cancel = "Cancel"
		case loading = "Loading"
		
		case russian = "Russian"
		case english = "English"
		case latvian = "Latvian"
		case system  = "System"
		
		
		
		static let tableName = "Common"
	}
	
	enum ScheduleTableView: String {
		case day = "Schedule.TableView.Day"
		case week = "Schedule.TableView.Week"
		case month = "Schedule.TableView.Month"
		
		case loadingFailed = "Schedule.TableView.LoadingFailed"
		
		
		
		static let tableName = "Localization"
	}
	
	enum ScheduleSettingsView: String {
		case filters  = "Schedule.SettingsView.Filters"
		case filter   = "Schedule.SettingsView.Filter"
		
		case group    = "Schedule.SettingsView.Group"
		case lecturer = "Schedule.SettingsView.Lecturer"
		case room     = "Schedule.SettingsView.Room"
		
		case filterValuesSetsLoadingError = "Schedule.SettingsView.LoadingError"
		case selectedGroupIsNotExist = "Schedule.SettingsView.SelectedGroupIsNotExist"
		case selectedLecturerIsNotExist = "Schedule.SettingsView.SelectedLecturerIsNotExist"
		case selectedRoomIsNotExist = "Schedule.SettingsView.SelectedRoomIsNotExist"
		
		
		
		static let tableName = "Localization"
	}
	
	enum PreferencesFormView: String {
		case language = "Preferences.FormView.Language"
		
		static let tableName = "Localization"
	}
}
