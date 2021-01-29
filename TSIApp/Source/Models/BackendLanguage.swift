enum BackendLanguage: String {
	case russian
	case english
	case latvian
	
	var code: String {
		let code: String
		
		switch self {
		case .russian:
			code = "ru"
		case .english:
			code = "en"
		case .latvian:
			code = "lv"
		}
		
		return code
	}
	
	static var `default`: Self { .russian }
}
