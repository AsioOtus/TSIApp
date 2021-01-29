import Foundation

public extension Data {
	var jsonString: String? {
		let jsonSerializationOptions: JSONSerialization.WritingOptions
		
		if #available(iOS 13.0, *) {
			jsonSerializationOptions = [.prettyPrinted, .withoutEscapingSlashes]
		} else {
			jsonSerializationOptions = [.prettyPrinted, .fragmentsAllowed]
		}
		
		guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
			let data = try? JSONSerialization.data(withJSONObject: object, options: jsonSerializationOptions),
			let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
		
		return prettyPrintedString as String
	}
}
