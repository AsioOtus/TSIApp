import Helpers
import BaseNetworkUtil
import Multitool

public protocol TSIRequest: Request { }

extension TSIRequest {
	static var method: String { "GET" }
	static var address: String { "https://services.tsi.lv/schedule/api/service.asmx/" }
	static var name: String { String(describing: Self.self) }
	static var url: URL { URL(string: address).unwrap("Cannot createURL from address: \"\(address)\" for request \(name)").appendingPathComponent(name) }
	
	public var urlRequest: URLRequest {
		URLRequest(url: Self.url)
	}
}



public protocol TSIResponse: ModellableResponse where Model: TSIResponseModel { }



public protocol TSIResponseModel: ResponseModel {
	init (_ data: Data) throws
}

public extension TSIResponseModel {
	static func fixResponseData (_ responseData: Data) throws -> Data {
		guard let responseDataString = String(data: responseData, encoding: .utf8)
		else { throw TSINetworkError.responseDataAsStringInterpretationFailed(responseData) }
		
		let result = AnyProcessor<String, TSINetworkError>
			.and([
				.process { $0.replacingOccurrences(of: "\\", with: "") },
				
				.longerThan(2, failure: { TSINetworkError.responseFixingFailed(error: "", dataString: $0) }),
				.process { $0.replacingOccurrences(of: ")(", with: "") },
				
				.longerThan(3, failure: { TSINetworkError.responseFixingFailed(error: "", dataString: $0) }),
				.process { String($0.dropLast(3)) },
				
				.longerThan(7, failure: { TSINetworkError.responseFixingFailed(error: "", dataString: $0) }),
				.process { String($0.dropFirst(7)) }
			])
			.process(responseDataString)
		
		let fixedResponseString = try result.value()
		let fixedResponseData = fixedResponseString.data(using: .utf8)!
		return fixedResponseData
	}
	
	init (_ data: Data) throws {
		let fixedData = try Self.fixResponseData(data)
		self = try JSONDecoder().decode(Self.self, from: fixedData)
	}
}
