import Alamofire

protocol Request: URLRequestConvertible {
	associatedtype Response: TSIApp.Response
	
	func session () throws -> Session
}



extension Request {
	func session () throws -> Session { AF }
}



protocol Response { }
