import LoggingUtil
import UserDefaultsUtil
import BaseNetworkUtil

extension DefaultLogger: UserDefaultsUtilLoggingProvider where DefaultLogger.Message == String  {
	public func userDefaultsUtilLog <Value> (_ info: UserDefaultsUtil.Logger.Info<Value>) {
		log(
			level: .info,
			message: info.defaultMessage,
			source: [info.userDefaultsItemTypeName]
		)
	}
}

let userDefaultUtilLogger = DefaultLogger(logHandler: DefaultLogHandler.standard, loggerInfo: .init(source: ["UserDefaultsUtil"], tags: ["UserDefaults"]))





extension DefaultLogger: BaseNetworkUtilControllersLoggingProvider where DefaultLogger.Message == String {
	public func baseNetworkUtilControllersLog (_ info: Controllers.Logger.Info) {
		log(
			level: .info,
			message: info.category.defaultMessage,
			source: [info.module, info.source]
		)
	}
}

let baseNetworkUtilLogger = DefaultLogger(logHandler: DefaultLogHandler.standard, loggerInfo: .init(tags: ["Network"]))
