public protocol LogDetailable {
	var logMessage: String { get }
}



extension String: LogDetailable {
	public var logMessage: String { self }
}



extension Dictionary: LogDetailable where Key == String, Value == String {
	public var logMessage: String {
		"\n" + self.map{ "\($0): \($1)" }.joined(separator: "\n") + "\n"
	}
}
