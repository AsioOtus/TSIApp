import Foundation

extension MTUserDefaults {
	open class Item <ItemType: Codable> {
		private lazy var logger = Logger(String(describing: Self.self))
		
		private let userDefaultsInstance: UserDefaults
		
		
		
		final var keyPrefix: String {
			guard let prefixProvider = MTUserDefaults.settings.items.itemKeyPrefixProvider else { fatalError("MTUserDefaults.settings.items.prefixProvider is nil") }
			let prefix = prefixProvider.userDefaultsItemPrefix
			return prefix
		}
		public final let itemKey: String
		public final var key: String { "\(keyPrefix).\(itemKey)" }
		public final func postfixedKey (_ postfixProvider: MTUserDefaultsItemKeyPostfixProvider?) -> String {
			guard let postfixProvider = postfixProvider else { return key }
			
			let postfix = postfixProvider.userDefaultsItemPostfix.trimmingCharacters(in: .whitespacesAndNewlines)
			
			guard !postfix.isEmpty else { return key }
			
			return "\(self.key).\(postfix)"
		}
		
		
		
		public init (_ itemKey: String, _ userDefaultsInstance: UserDefaults = .standard) {
			self.itemKey = itemKey
			self.userDefaultsInstance = userDefaultsInstance
		}
	}
}



public extension MTUserDefaults.Item {
	@discardableResult
	func save (_ object: ItemType) -> Bool {
		save(object, nil)
	}
	
	func load () -> ItemType? {
		load(nil)
	}
	
	func delete () {
		delete(nil)
	}
	
	func isExists () -> Bool {
		isExists(nil)
	}
}



internal extension MTUserDefaults.Item {
	@discardableResult
	func save (_ object: ItemType, _ keyPostfixProvider: MTUserDefaultsItemKeyPostfixProvider? = nil) -> Bool {
		let key = postfixedKey(keyPostfixProvider)
		let logRecord = Logger.Record(.saving(object), key)
		
		do {
			let data = try Self.encode(object)
			userDefaultsInstance.set(data, forKey: key)
			
			logger.log(logRecord.commit(.saving))
			
			return true
		} catch {
			logger.log(logRecord.commit(.genericError(error)))
			
			return false
		}
	}
	
	func load (_ keyPostfixProvider: MTUserDefaultsItemKeyPostfixProvider? = nil) -> ItemType? {
		let key = postfixedKey(keyPostfixProvider)
		let logRecord = Logger.Record(.loading, key)
		
		do {
			guard let data = userDefaultsInstance.string(forKey: key) else { throw Error.itemNotFound }
			let object = try Self.decode(data, ItemType.self)
			
			logger.log(logRecord.commit(.loading(object)))
			
			return object
		} catch {
			logger.log(logRecord.commit(.genericError(error)))
			
			return nil
		}
	}
	
	func delete (_ keyPostfixProvider: MTUserDefaultsItemKeyPostfixProvider? = nil) {
		let key = postfixedKey(keyPostfixProvider)
		let logRecord = Logger.Record(.deletion, key)
		
		userDefaultsInstance.removeObject(forKey: key)
		
		logger.log(logRecord.commit(.deletion))
	}
	
	func isExists (_ keyPostfixProvider: MTUserDefaultsItemKeyPostfixProvider? = nil) -> Bool {
		let key = postfixedKey(keyPostfixProvider)
		let logRecord = Logger.Record(.existance, key)
		
		do {
			let object: ItemType?
			let isExists: Bool
			
			if let data = userDefaultsInstance.string(forKey: key) {
				object = try Self.decode(data, ItemType.self)
				isExists = true
			} else {
				object = nil
				isExists = false
			}
			
			logger.log(logRecord.commit(.existance(isExists, object)))
			
			return isExists
		} catch {
			logger.log(logRecord.commit(.genericError(error)))
			
			return false
		}
	}
}



private extension MTUserDefaults.Item {
	static func encode <T: Encodable> (_ object: T) throws -> String {
		do {
			let jsonData = try JSONEncoder().encode(object)
			guard let jsonString = String(data: jsonData, encoding: .utf8) else { throw Error.jsonDataDecodingFailed(jsonData.base64EncodedString()) }
			return jsonString
		} catch let error as Error {
			throw error
		} catch {
			throw Error.encodingFailed(error)
		}
	}
	
	static func decode <T: Decodable> (_ jsonString: String, _ type: T.Type) throws -> T {
		do {
			guard let jsonData = jsonString.data(using: .utf8) else { throw Error.jsonStringEncodingFailed(jsonString) }
			let object = try JSONDecoder().decode(type, from: jsonData)
			return object
		} catch let error as Error {
			throw error
		} catch {
			throw Error.decodingFailed(error)
		}
	}
}
