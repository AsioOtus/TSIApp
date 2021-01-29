import Foundation

extension MTUserDefaults.Item {
	public enum Error: Swift.Error {
		case itemNotFound
		
		case jsonDataDecodingFailed(String)
		case jsonStringEncodingFailed(String)
		
		case encodingFailed(Swift.Error)
		case decodingFailed(Swift.Error)
	}
}



extension MTUserDefaults.Item.Error: CustomStringConvertible {
	public var description: String {
		let description: String
		
		switch self {
		case .itemNotFound:
			description = "Item not found"
			
		case .jsonDataDecodingFailed(let jsonDataBase64):
			description = "JSON data decoding failed – \(jsonDataBase64)"
		case .jsonStringEncodingFailed(let jsonString):
			description = "JSON string encoding failed – \(jsonString)"
			
		case .encodingFailed(let error):
			description = "Encoding error – \(error.localizedDescription)"
		case .decodingFailed(let error):
			description = "Decoding error – \(error.localizedDescription)"
		}
		
		return description
	}
}
