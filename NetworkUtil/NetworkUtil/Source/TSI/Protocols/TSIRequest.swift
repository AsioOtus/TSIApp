import Helpers
import BaseNetworkUtil

public protocol TSIRequest: Request where Response: TSIResponse { }

extension TSIRequest {
	static var method: String { "GET" }
	static var address: String { "https://services.tsi.lv/schedule/api/service.asmx/" }
	static var name: String { String(describing: Self.self) }
	static var url: URL { URL(string: address).unwrap("Cannot createURL from address: \"\(address)\" for request \(name)").appendingPathComponent(name) }
	
	public func urlRequest () throws -> URLRequest {
		URLRequest(url: Self.url)
	}
}



public protocol TSIResponse: ModelableResponse where Model: TSIResponseModel { }

extension TSIResponse {
	public init (_ urlResponse: URLResponse, _ data: Data) throws {
		let model = try Self.Model(data)
		self.init(model)
	}
}



public protocol TSIResponseModel: ResponseModel {
	init (_ data: Data) throws
}

public extension TSIResponseModel {
	init (_ data: Data) throws {
		self = try JSONDecoder().decode(Self.self, from: data)
	}
}
