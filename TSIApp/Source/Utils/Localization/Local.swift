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
		NSLocalizedString(key, tableName: tableName, bundle: localizedBundle, value: key, comment: "")
	}
}
