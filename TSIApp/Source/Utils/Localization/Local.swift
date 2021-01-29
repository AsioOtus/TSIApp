import Foundation

struct Local {
	static var shared = Self()
	private init () { }
	
	private var localizedBundle: Bundle = {
		let currentLanguage = App.State.current.language
		let bundle = Self.localizedBundle(currentLanguage)
		return bundle
	}()
	
	mutating func updateCurrentLanguage (_ newLanguage: FrontendLanguage) {
		let bundle = Self.localizedBundle(newLanguage)
		localizedBundle = bundle
	}

	private static func localizedBundle (_ language: FrontendLanguage) -> Bundle {
		let languageCode = language.code ?? FrontendLanguage.default.code.unwrap("Can not get default language code")
		
		if
			let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
			let bundle = Bundle(path: path)
		{
			return bundle
		} else {
			return Bundle.main
		}
	}
	
	private func localize (_ key: String, _ tableName: String) -> String {
		NSLocalizedString(key, tableName: tableName, bundle: localizedBundle, value: key, comment: "")
	}
	
	static subscript (_ key: Keys.Common) -> String {
		shared.localize(key.rawValue, Keys.Common.tableName)
	}
	
	static subscript (_ key: Keys.ScheduleTableView) -> String {
		shared.localize(key.rawValue, Keys.ScheduleTableView.tableName)
	}
	
	static subscript (_ key: Keys.ScheduleSettingsView) -> String {
		shared.localize(key.rawValue, Keys.ScheduleSettingsView.tableName)
	}
	
	static subscript (_ key: Keys.PreferencesFormView) -> String {
		shared.localize(key.rawValue, Keys.PreferencesFormView.tableName)
	}
}
