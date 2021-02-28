extension TSI.Requests {
	public struct GetItems: TSIRequest {
		public typealias GetItems = TSI.Requests.GetItems
		
		public init () { }
		
		public struct Response: TSIResponse {			
			public let model: Model
			
			public init (_ model: Model) {
				self.model = model
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
