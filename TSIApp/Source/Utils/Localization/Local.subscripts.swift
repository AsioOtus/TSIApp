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
