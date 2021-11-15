import Foundation

struct Local {
	static var shared = Self()
	private init () { }
	
	var localizedBundle: Bundle = {
		let currentLanguage = App.State.current.language
		let bundle = Self.localizedBundle(currentLanguage)
		return bundle
	}()
	
	mutating func updateCurrentLanguage (_ newLanguage: FrontendLanguage) {
		let bundle = Self.localizedBundle(newLanguage)
		localizedBundle = bundle
	}

	private static func localizedBundle (_ language: FrontendLanguage) -> Bundle {
		let languageCode = language.code
		
		if
			let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
			let bundle = Bundle(path: path)
		{
			return bundle
		} else {
			return Bundle.main
		}
	}
	
	func localize (_ key: String, _ tableName: String) -> String {
		localize(key, tableName, localizedBundle)
	}
	
	func localize (_ key: String, _ tableName: String, _ language: FrontendLanguage) -> String {
		let localizedBundle = Self.localizedBundle(language)
		let localizedString = localize(key, tableName, localizedBundle)
		return localizedString
	}
	
	func localize (_ key: String, _ tableName: String, _ localizedBundle: Bundle) -> String {
		let localizedString = NSLocalizedString(key, tableName: tableName, bundle: localizedBundle, value: "!\(key)", comment: "")
		return localizedString
	}
}
