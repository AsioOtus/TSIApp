extension Schedule {
	enum EmptyLecturesDisplaying: String, Codable, CaseIterable {
		case none
		case untilNonEmpty
		case all
	}
}

extension Schedule.EmptyLecturesDisplaying {
	var localizationKey: Local.Keys.ScheduleSettingsView {
		switch self {
		case .none: return .noneLectures
		case .untilNonEmpty: return  .untilNonEmptyLecture
		case .all: return  .allLectures
		}
	}
}
