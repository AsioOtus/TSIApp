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
		
		case inDevelopment = "InDevelopment"
		
		
		
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
		
		case aboutDescriptionTitle = "Preferences.AboutView.Title.Description"
		case aboutSupportTitle = "Preferences.AboutView.Title.Support"
		
		case aboutIntroduction = "Preferences.AboutView.Introduction"
		case aboutDescription = "Preferences.AboutView.Description"
		case aboutFeatures = "Preferences.AboutView.Features"
		case aboutNotOfficial = "Preferences.AboutView.NotOfficial"
		case aboutNotOfficialButtonText = "Preferences.AboutView.LinkToOfficial.ButtonText"
		
		case aboutDeveloper = "Preferences.AboutView.Developer"
		case aboutDeveloperName = "Preferences.AboutView.DeveloperName"
		
		case aboutReportABugDescription = "Preferences.AboutView.ReportABugDescription"
		case aboutReportABug = "Preferences.AboutView.ReportABug"
		case aboutMailSubject = "Preferences.AboutView.MailSubject"
		
		
		
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
