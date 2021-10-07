import BaseNetworkUtil

extension TSI.Requests {
	public struct GetLocalizedEvents: TSIRequest {
		public typealias GetLocalizedEvents = TSI.Requests.GetLocalizedEvents
		
		public let model: Model
		public let urlRequest: URLRequest
		
		public init (_ model: Model) throws {
			self.model = model
			self.urlRequest = try Self.createUrlRequest(model)
		}
		
		public static func createUrlRequest (_ model: Model) throws -> URLRequest {
			guard var components = URLComponents(string: Self.url.absoluteString) else { throw TSINetworkError.urlRequestCreationFailed("Cannot create URLComponents from URL \"\(Self.url.absoluteString)\"") }
			
			components.queryItems = model.dictionary.map { (key, value) in
				URLQueryItem(name: key, value: value)
			}
			components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
			
			guard let url = components.url else { throw TSINetworkError.urlRequestCreationFailed("Cannot get URL from components: \"\(components)\"") }
			
			let urlRequest = URLRequest(url: url)
			return urlRequest
		}
		
		public struct Model {
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



extension TSI.Requests.GetLocalizedEvents {
	public struct Response: TSIResponse {
		public let data: Data
		public let urlResponse: URLResponse
		public let model: Model
		
		public init (_ data: Data, _ urlResponse: URLResponse) throws {
			self.urlResponse = urlResponse
			self.data = data
			self.model = try Self.Model(data)
		}
		
		public struct Model: TSIResponseModel {
			public let events: [Event]
			
			public init (_ data: Data) throws {
				let fixedData = try Self.fixResponseData(data)
				events = try Parser.parse(fixedData)
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
