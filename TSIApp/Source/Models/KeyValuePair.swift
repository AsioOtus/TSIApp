struct KeyValuePair <Key: Hashable, Value: Hashable>: Hashable {	
	let key: Key
	let value: Value
	
	init (_ key: Key, _ value: Value) {
		self.key = key
		self.value = value
	}
}
