import Foundation
import SwiftDate



enum FrontendLanguage: String, CaseIterable, Codable {
	case system
	case russian
	case english
	case latvian
	
	var code: String? {
		let code: String?
		
		switch self {
		case .system:
			code = Locale.current.languageCode
		case .russian:
			code = "ru"
		case .english:
			code = "en"
		case .latvian:
			code = "lv"
		}
		
		return code
	}
	
	var backendLanguage: BackendLanguage {
		let language: BackendLanguage
		
		switch self {
		case .system:
			if let nonSystemLanguage = Self.nonSystemLanguages.first(where: { $0.code == code }) {
				language = nonSystemLanguage.backendLanguage
			} else {
				language = BackendLanguage.default
			}
		case .russian:
			language = .russian
		case .english:
			language = .english
		case .latvian:
			language = .latvian
		}
		
		return language
	}
	
	var swiftDateLocale: Locales {
		let locale: Locales
		
		switch self {
		case .system:
			locale = .autoUpdating
		case .russian:
			locale = .russian
		case .english:
			locale = .english
		case .latvian:
			locale = .latvian
		}
		
		return locale
	}
	
	// Can not be .system case
	static var `default`: Self { .russian }
	
	static var nonSystemLanguages: [Self] { allCases.filter { $0 != .system } }
}



extension FrontendLanguage {
	var localizationKey: Local.Keys.Common {
		let key: Local.Keys.Common
		
		switch self {
		case .system:
			key = .system
		case .russian:
			key = .russian
		case .english:
			key = .english
		case .latvian:
			key = .latvian
		}
		
		return key
	}
}
