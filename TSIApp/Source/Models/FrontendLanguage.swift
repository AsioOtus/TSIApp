import Foundation
import SwiftDate

extension FrontendLanguage: Codable {
	enum CodingKeys: CodingKey {
		case system
		case app
	}
	
	init (from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let key = container.allKeys.first
		
		switch key {
		case .system:
			self = .system
			
		case .app:
			let appLanguage = try container.decode(AppLanguage.self, forKey: .app)
			self = .app(appLanguage)
			
		default:
			throw DecodingError.dataCorrupted(
				DecodingError.Context(codingPath: container.codingPath,	debugDescription: "Unabled to decode enum.")
			)
		}
	}
	
	func encode (to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		switch self {
		case .system:
			try container.encode(true, forKey: .system)
			
		case .app(let language):
			try container.encode(language, forKey: .app)
		}
	}
}

extension FrontendLanguage: Equatable { }

enum FrontendLanguage {
	case system
	case app(AppLanguage)
	
	var code: String? {
		switch self {
		case .system: return Locale.current.languageCode
		case .app(let language): return language.code
		}
	}
	
	var appLanguage: AppLanguage? {
		switch self {
		case .system: return nil
		case .app(let language): return language
		}
	}
	
	var appLanguageOrSystem: AppLanguage? {
		switch self {
		case .system:
			let currentLanguageCode = Locale.current.languageCode
			if let appLanguage = AppLanguage.availableLanguages.first(where: { $0.code == currentLanguageCode }) {
				return appLanguage
			}
			
			let preferedLanguages = Locale.preferredLanguages
			if let appLanguage = AppLanguage.availableLanguages.first(where: { preferedLanguages.contains($0.code) }) {
				return appLanguage
			}
			
			return nil
			
		case .app(let language): return language
		}
	}
	
	var appLanguageOrDefault: AppLanguage {
		appLanguage ?? .default
	}
	
	var swiftDateLocale: Locales {
		switch self {
		case .system: return .autoUpdating
		case .app(let language): return language.swiftDateLocale
		}
	}
}

extension FrontendLanguage {
	var localizationKey: Local.Keys.Common {
		switch self {
		case .system: return .system
		case .app(let language): return language.localizationKey
		}
	}
}

enum AppLanguage: String, CaseIterable, Codable {
	case russian
	case english
	case latvian
	
	static var `default`: Self { .russian }
	static var availableLanguages: [Self] { [.russian, .english] }
	
	var code: String {
		switch self {
		case .russian: return "ru"
		case .english: return "en"
		case .latvian: return "lv"
		}
	}
	
	var backendLanguage: BackendLanguage {
		switch self {
		case .russian: return .russian
		case .english: return .english
		case .latvian: return .latvian
		}
	}
	
	var swiftDateLocale: Locales {
		switch self {
		case .russian: return .russian
		case .english: return .english
		case .latvian: return .latvian
		}
	}
	
	var nativeName: String {
		switch self {
		case .russian: return "Русский"
		case .english: return "English"
		case .latvian: return "Latviešu"
		}
	}
	
	var flagEmoji: String {
		switch self {
		case .russian: return "🇷🇺"
		case .english: return "🇬🇧"
		case .latvian: return "🇱🇻"
		}
	}
	
	var localizationKey: Local.Keys.Common {
		switch self {
		case .russian: return .russian
		case .english: return .english
		case .latvian: return .latvian
		}
	}
}
