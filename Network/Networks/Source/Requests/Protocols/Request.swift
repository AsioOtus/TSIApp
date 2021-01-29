import Alamofire



public protocol Request: URLRequestConvertible {
	associatedtype Response: Networks.Response
	
	func session () throws -> Session
}



public extension Request {
	func session () throws -> Session { AF }
}



public protocol Response { }

