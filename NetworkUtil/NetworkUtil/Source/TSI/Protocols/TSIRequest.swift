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
	static func fixResponseData (_ responseData: Data) throws -> Data {
		guard let responseDataString = String(data: responseData, encoding: .utf8)
		else { throw TSINetworkError.responseDataAsStringInterpretationFailed(responseData) }
		
		var fixedResponseDataString = responseDataString.replacingOccurrences(of: "\\", with: "")
		
		guard fixedResponseDataString.count >= 2 else { throw TSINetworkError.responseFixingFailed(error: "", dataString: responseDataString) }
		fixedResponseDataString = fixedResponseDataString.replacingOccurrences(of: ")(", with: "")
		
		guard fixedResponseDataString.count >= 3 else { throw TSINetworkError.responseFixingFailed(error: "", dataString: responseDataString) }
		fixedResponseDataString.removeLast(3)
		
		guard fixedResponseDataString.count >= 7 else { throw TSINetworkError.responseFixingFailed(error: "", dataString: responseDataString) }
		fixedResponseDataString.removeFirst(7)
		
		let fixedResponseData = fixedResponseDataString.data(using: .utf8)!
		return fixedResponseData
	}
	
	init (_ data: Data) throws {
		let fixedData = try Self.fixResponseData(data)
		self = try JSONDecoder().decode(Self.self, from: fixedData)
	}
}
