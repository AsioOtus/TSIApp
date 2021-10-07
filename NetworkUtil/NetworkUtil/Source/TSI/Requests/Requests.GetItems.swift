extension TSI.Requests {
	public struct GetItems: TSIRequest {
		public init () { }
		
		public struct Response: TSIResponse {			
			public var data: Data
			public var urlResponse: URLResponse
			public let model: Model
			
			public init (_ data: Data, _ urlResponse: URLResponse) throws {
				self.urlResponse = urlResponse
				self.data = data
				self.model = try Self.Model(data)
			}
			
			public struct Model: TSIResponseModel {
				public let groups:    [String: String]
				public let lecturers: [String: String]
				public let rooms:     [String: String]
				
				enum CodingKeys: String, CodingKey {
					case groups
					case lecturers = "teachers"
					case rooms
				}
			}
		}
	}
}
