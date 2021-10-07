extension Schedule.Event {
	enum Class: CaseIterable {
		case empty
		case unknown
		
		var stringCode: String? {
			let stringCode: String?
			
			switch self {
			case .empty:
				stringCode = ""
			case .unknown:
				stringCode = nil
			}
			
			return stringCode
		}
		
		init (_ stringCode: String) {
			self = Self.allCases.first{ $0.stringCode == stringCode } ?? .unknown
		}
	}
}
