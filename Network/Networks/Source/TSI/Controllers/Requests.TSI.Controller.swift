import Combine
import Alamofire
import Log



extension Requests.TSI.Controller {
	private class Logger {
		static let logger: Log = {
			let log = Log(subsystem: "Network", module: "TSI.Controller", category: "network")
			log.settings = .init(prefix: "TA", enabled: true)
			return log
		}()
		
		static func request (_ urlRequest: URLRequest) {
			let message = "Request – \(urlRequest.debugDescription)"
			let details =
			"""

			HEADERS:
			\(urlRequest.allHTTPHeaderFields?.description ?? "No headers")
			
			BODY:
			\(urlRequest.httpBody?.jsonString ?? "No body")

			"""
			
			logger.debug(message, details: details)
		}
		
		static func response (_ response: AFDataResponse<String>) {
			let message = "Response – \(response.request?.debugDescription ?? "No request info") – \(response.response?.statusCode.description ?? "No code")"
			let details =
			"""

			HEADERS:
			\(response.response?.allHeaderFields.description ?? "No headers")
			
			BODY:
			\(response.data?.jsonString ?? "No data")
			
			\(String(describing: response.value))
			
			"""
			
			logger.debug(message, details: details)
		}
		
		static func error <RequestDelegate: TSIRequestDelegate> (_ requestDelegate: RequestDelegate, _ error: Swift.Error) {
			logger.error("Request", error: error)
		}
		
		static func error (_ response: AFDataResponse<String>, _ error: Swift.Error) {
			logger.error("Response", errorMessage: response.request?.debugDescription ?? "No request info", error: error)
		}
	}
}



extension Requests.TSI {
	public struct Controller {
		public static let shared = Controller()
		private init () { }
		
		public func send <RequestDelegate: TSIRequestDelegate> (_ requestDelegate: RequestDelegate) -> Future<RequestDelegate.Content, Error> {
			Future<RequestDelegate.Content, Error> { promise in
				do {
					let request = try requestDelegate.build()
					let urlRequest = try request.asURLRequest()
					let session = try request.session()
					
					session.request(urlRequest).responseString { stringResponse in
						self.handleResponse(stringResponse, promise, requestDelegate)
					}
					
					Logger.request(urlRequest)
				} catch let error as Error {
					Logger.error(requestDelegate, error)
					promise(.failure(error))
				} catch {
					Logger.error(requestDelegate, error)
					promise(.failure(Error.sending(error)))
				}
			}
		}
		
		private func handleResponse <RequestDelegate: TSIRequestDelegate> (
			_ dataResponse: AFDataResponse<String>,
			_ promise: (Result<RequestDelegate.Content, Error>) -> Void,
			_ requestDelegate: RequestDelegate
		) {
			do {
				if let error = dataResponse.error { throw Error.response(error) }
				
				guard let value = dataResponse.value else { throw Error.valueIsMissing(dataResponse) }
				guard let fixedResponseValue = Self.fixResponseValue(value) else { throw Error.responseValueFixFailed(value) }
				guard let responseData = fixedResponseValue.data(using: .utf8) else { throw Error.responseConversionToDataFailed(fixedResponseValue) }
				
				let response = try RequestDelegate.Request.Response(responseData)
				let content = try requestDelegate.convert(response)
				
				Logger.response(dataResponse)
				
				promise(.success(content))
			} catch let error as Error {
				Logger.error(dataResponse, error)
				promise(.failure(error))
			} catch {
				Logger.error(dataResponse, error)
				promise(.failure(Error.receiving(error)))
			}
		}
		
		private static func fixResponseValue (_ responseString: String) -> String? {
			var fixedResponse = responseString.replacingOccurrences(of: "\\", with: "")
			
			guard fixedResponse.count >= 2 else { return nil }
			fixedResponse = fixedResponse.replacingOccurrences(of: ")(", with: "")
			
			guard fixedResponse.count >= 3 else { return nil }
			fixedResponse.removeLast(3)
			
			guard fixedResponse.count >= 7 else { return nil }
			fixedResponse.removeFirst(7)
			
			return fixedResponse
		}
	}
}
