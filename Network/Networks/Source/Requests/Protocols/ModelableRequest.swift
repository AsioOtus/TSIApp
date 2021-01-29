protocol ModelableRequest: Request {
	associatedtype Model: RequestModel
	
	var model: Model { get }
}

protocol RequestModel: Encodable { }
