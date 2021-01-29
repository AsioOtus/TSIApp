import os.log



extension Log {
	public struct Settings {
		public static let `default` = Settings(prefix: nil)
		
		public var prefix: String?
		public var enabled: Bool
		
		public init (prefix: String?, enabled: Bool = true) {
			self.prefix = prefix
			self.enabled = enabled
		}
	}
}



open class Log {
	public static let `default` = Log(subsystem: nil, module: nil, category: "default")
	public var settings = Settings.default
	
	public let subsystem: String?
	public let module: String?
	public let category: String?
	public let osLog: OSLog
	
	public init (subsystem: String?, module: String?, category: String?) {
		self.subsystem = subsystem
		self.category = category
		self.module = module
		self.osLog = OSLog(subsystem: subsystem ?? "", category: category ?? "")
	}
}



public extension Log {
	func log (logType: OSLogType, message: String, errorMessage: String? = nil, error: Error? = nil, details: LogDetailable? = nil) {
		let (prefixPart, errorPart, detailsPart) = logMessageParts(subsystem, module, errorMessage, error, details)
		let logMessage = createMessage(messageParts: [prefixPart, message, errorPart, detailsPart])
		log(logType: logType, message: logMessage)
	}
	
	func log (logType: OSLogType, message: String) {
		guard settings.enabled else { return }
		os_log("%{public}@", log: osLog, type: logType, message)
	}
	
	func `default` (_ message: String, details: LogDetailable? = nil) {
		log(logType: .default, message: message, details: details)
	}
	
	func info (_ message: String, details: LogDetailable? = nil) {
		log(logType: .info, message: message, details: details)
	}
	
	func debug (_ message: String, details: LogDetailable? = nil) {
		log(logType: .debug, message: message, details: details)
	}
	
	func error (_ message: String, errorMessage: String? = nil, error: Error?, details: LogDetailable? = nil) {
		log(logType: .error, message: message, errorMessage: errorMessage, error: error, details: details)
	}
	
	func fault (_ message: String, errorMessage: String? = nil, error: Error?, details: LogDetailable? = nil) {
		log(logType: .fault, message: message, errorMessage: errorMessage, error: error, details: details)
	}
}



public extension Log {
	func logMessageParts
		(_ subsystem: String?, _ module: String?, _ errorMessage: String?, _ error: Error?, _ details: LogDetailable?) ->
		(prefixPart: String?, errorPart: String?, detailsPart: String?)
	{
		let prefixPart = Log.prefixPart(settings.prefix, subsystem, module)
		let errorPart = Log.errorPart(errorMessage, error)
		let detailsPart = Log.detailsPart(details)
		
		return (prefixPart, errorPart, detailsPart)
	}
	
	func createMessage (messageParts: [String?]) -> String {
		let logMessage = messageParts.compactMap{ $0 }.joined(separator: " | ")
		return logMessage
	}
}



private extension Log {
	static func prefixPart (_ prefix: String?, _ subsystem: String?, _ module: String?) -> String? {
		guard prefix != nil, subsystem != nil, module != nil else { return nil }
		return [prefix, subsystem, module].compactMap{ $0 }.joined(separator: ".")
	}
	
	static func errorPart (_ errorMessage: String?, _ error: Error?) -> String? {
		guard errorMessage != nil, error != nil else { return nil }
		return [errorMessage, error?.localizedDescription].compactMap{ $0 }.joined(separator: " – ")
	}
	
	static func detailsPart (_ details: LogDetailable?) -> String? {
		guard let details = details else { return nil }
		return "DETAILS: \(details.logMessage)"
	}
}
