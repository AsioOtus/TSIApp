import SwiftyJSON



extension Requests.TSI.GetLocalizedEvents.Response.Model.Parser {
	struct Error: Swift.Error {
		let category: Category
		let json: String
		
		init (_ category: Category, _ json: JSON) {
			self.category = category
			self.json = json.rawString() ?? "JSON is nil"
		}
		
		enum Category {
			case eventsNotFound
			
			case keysNotFound
			case valuesNotFound
			
			case keyNotFound(Key, keys: [String])
			case valueParsingFailed(Key)
		}
	}
	
	enum Key: String, CaseIterable {
		case time
		case rooms = "room"
		case groups
		case lecturer = "teacher"
		case name
		case comment
		case `class`
	}
	
	struct KeysIndices {
		let	time, rooms, groups, lecturer, name, comment, `class`: Int
		
		func index (_ key: Key) -> Int {
			let index: Int
			
			switch key {
			case .time:
				index = time
			case .rooms:
				index = rooms
			case .groups:
				index = groups
			case .lecturer:
				index = lecturer
			case .name:
				index = name
			case .comment:
				index = comment
			case .class:
				index = `class`
			}
			
			return index
		}
	}
}



extension Requests.TSI.GetLocalizedEvents.Response.Model {
	struct Parser {
		static func parse (_ jsonData: Data) throws -> [Event] {
			let json = try JSON(data: jsonData)
			
			let eventsKey = "events"
			let keysKey = "keys"
			let valuesKey = "values"
			
			guard let eventsJsonDisctionary = json[eventsKey].dictionary else { throw Error(.eventsNotFound, json) }
			
			guard let keys = eventsJsonDisctionary[keysKey]?.array?.compactMap({ $0.string }) else { throw Error(.keysNotFound, json) }
			let keysIndices = try getKeysIndices(keys, json)
			
			guard let values = eventsJsonDisctionary[valuesKey]?.array?.compactMap({ $0.array }) else { throw Error(.valuesNotFound, json) }
			let events = try values.map { try createEvent($0, keysIndices, json) }
			
			return events
		}
	}
}



private extension Requests.TSI.GetLocalizedEvents.Response.Model.Parser {
	static func getKeysIndices (_ keys: [String], _ json: JSON) throws -> KeysIndices {
		func getKeyIndex (_ key: Key) throws -> Int {
			guard let index = keys.firstIndex(of: key.rawValue) else { throw Error(.keyNotFound(key, keys: keys), json) }
			return index
		}
		
		let time = try getKeyIndex(.time)
		let rooms = try getKeyIndex(.rooms)
		let groups = try getKeyIndex(.groups)
		let lecturer = try getKeyIndex(.lecturer)
		let name = try getKeyIndex(.name)
		let comment = try getKeyIndex(.comment)
		let `class` = try getKeyIndex(.class)
		
		let keys = KeysIndices(time: time, rooms: rooms, groups: groups, lecturer: lecturer, name: name, comment: comment, class: `class`)
		return keys
	}
	
	static func createEvent (_ jsonArray: [JSON], _ keysIndices: KeysIndices, _ json: JSON) throws -> Requests.TSI.GetLocalizedEvents.Response.Model.Event {
		func getIntValue (_ key: Key) throws -> Int {
			guard let value = jsonArray[keysIndices.index(key)].int else { throw Error(.valueParsingFailed(key), json) }
			return value
		}
		
		func getStringValue (_ key: Key) throws -> String {
			let value = jsonArray[keysIndices.index(key)].stringValue
			return value
		}
		
		func getArrayValue (_ key: Key) throws -> [String] {
			guard let array = jsonArray[keysIndices.index(key)].array else { throw Error(.valueParsingFailed(key), json) }
			let values = array.compactMap { ($0.int) }.map { String($0) }
			return values
		}
		
		let time = try getIntValue(.time)
		let rooms = try getArrayValue(.rooms)
		let groups = try getArrayValue(.groups)
		let lecturer = try getStringValue(.lecturer)
		let name = try getStringValue(.name)
		let comment = try getStringValue(.comment)
		let `class` = try getStringValue(.class)
		
		let event = Requests.TSI.GetLocalizedEvents.Response.Model.Event(
			time: time,
			groups: groups,
			lecturer: lecturer,
			rooms: rooms,
			name: name,
			comment: comment,
			class: `class`
		)
		
		return event
	}
}
