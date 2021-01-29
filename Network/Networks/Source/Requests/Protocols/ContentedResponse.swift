protocol ContentedResponse: Response {
	associatedtype Content: ResponseContent
	
	func content () throws -> Content
}



protocol ResponseContent { }
