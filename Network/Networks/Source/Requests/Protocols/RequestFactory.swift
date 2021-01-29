public protocol RequestDelegate {
	associatedtype Request: Networks.Request
	associatedtype Content
	
	func build () throws -> Request
	func convert (_: Request.Response) throws -> Content
}
