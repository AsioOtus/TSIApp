extension Requests.TSI {
	public struct GetLocalizedEvents: TSIRequest, ModelableRequest {
		public typealias GetLocalizedEvents = Requests.TSI.GetLocalizedEvents
		
		public init (model: Model) { self.model = model }
		
		public let model: Model
		
		public func asURLRequest () throws -> URLRequest {
			guard var components = URLComponents(string: Self.url.absoluteString) else { throw Error.urlRequestCreationFailed("Cannot create URLComponents from URL \"\(Self.url.absoluteString)\"") }
			
			components.queryItems = model.dictionary.map { (key, value) in
				URLQueryItem(name: key, value: value)
			}
			components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
			
			guard let url = components.url else { throw Error.urlRequestCreationFailed("Cannot get URL from components: \"\(components)\"") }
			
			let urlRequest = try URLRequest(url: url, method: Self.method)
			return urlRequest
		}
		
		public struct Model: RequestModel {
			public init (from: Int, to: Int, groups: [String], lecturers: [String], rooms: [String], language: String) {
				self.from = from
				self.to = to
				self.groups = groups
				self.lecturers = lecturers
				self.rooms = rooms
				self.language = language
			}
			
			let from: Int
			let to: Int
			let groups: [String]
			let lecturers: [String]
			let rooms: [String]
			let language: String
			
			var dictionary: [String: String] {
				let valuesSeparator = ","
				
				let dictionary = [
					CodingKeys.from.rawValue:      from.description,
					CodingKeys.to.rawValue:        to.description,
					CodingKeys.groups.rawValue:    groups.joined(separator: valuesSeparator),
					CodingKeys.lecturers.rawValue: lecturers.joined(separator: valuesSeparator),
					CodingKeys.rooms.rawValue:     rooms.joined(separator: valuesSeparator),
					CodingKeys.language.rawValue:  "\"\(language)\""
				]
				
				return dictionary
			}
			
			enum CodingKeys: String, CodingKey {
				case from
				case to
				case groups
				case lecturers = "teachers"
				case rooms
				case language = "lang"
			}
		}
	}
}



extension Requests.TSI.GetLocalizedEvents {
	public struct Response: TSIResponse {
		public let model: Model
		
		public init (_ model: Model) {
			self.model = model
		}
		
		public struct Model: TSIResponseModel {
			public let events: [Event]
			
			public init (_ data: Data) throws {
				events = try Parser.parse(data)
			}
			
			public struct Event: Decodable {
				public let time: Int
				public let groups: [String]
				public let lecturer: String
				public let rooms: [String]
				public let name: String
				public let comment: String
				public let `class`: String
			}
		}
	}
}
