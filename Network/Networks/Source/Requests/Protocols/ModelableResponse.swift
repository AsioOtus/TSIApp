public protocol ModelableResponse: Response {
	associatedtype Model: ResponseModel
	
	var model: Model { get }
	
	init(_: Model)
}

public protocol ResponseModel: Decodable { }
