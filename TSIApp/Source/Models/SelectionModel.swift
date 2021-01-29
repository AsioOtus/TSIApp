typealias SelectionModel = KeyValuePair<String, String>



extension SelectionModel: Codable {
	enum CodingKeys: String, CodingKey {
		case key
		case value
	}
	
	init (from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		key = try container.decode(String.self, forKey: .key)
		value = try container.decode(String.self, forKey: .value)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(key, forKey: .key)
		try container.encode(value, forKey: .value)
	}
}



extension SelectionModel {
	static let empty = Self("", "")
}
