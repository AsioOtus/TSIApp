import LoggingUtil
import UserDefaultsUtil
import BaseNetworkUtil
import Multitool

extension StandardLogger: UserDefaultsUtil.LogHandler where Message == String  {
	public func log <Value> (_ logRecord: UserDefaultsUtil.LogRecord<Value>) {
		log(level: .info, message: logRecord.converted())
	}
}

let userDefaultsUtilLogger =
	StandardLogger(
		Logging.centralHandler,
		label: "Logger.UserDefaults"
	)
	.details(.init(source: ["UserDefaultsUtil"], tags: ["UserDefaults"]))
	.configuration(.init([.switchHandler: "UserDefaultsUtil"]))



private let networkLogRecordStringConverter = StandardLogRecordStringConverter(
	requestInfo: StandardRequestInfoStringConverter().convert,
	urlRequest: URLRequestStringConverters.Default().convert,
	urlResponse: URLResponseStringConverters.Default().convert,
	httpUrlResponse: HTTPURLResponseStringConverters.Default().convert,
	controllerError: StandardControllerErrorStringConverter(
		urlRequestConverter: URLRequestStringConverters.Default().convert,
		urlErrorConverter: { $0.localizedDescription }
	).convert
)
extension StandardLogger: BaseNetworkUtil.ControllerLogHandler where Message == String, Details == StandardRecordDetails {
	public func log (_ logRecord: NetworkController.Logger.LogRecord<NetworkController.Logger.BaseDetails>) {
		log(
			level: .info,
			message: logRecord.convert(networkLogRecordStringConverter),
			details:
				.init(
					source: [logRecord.details.type, logRecord.requestInfo.delegate] + logRecord.requestInfo.source
				)
		)
	}
}

let baseNetworkUtilLogger =
	StandardLogger(Logging.centralHandler, label: "Logger.Network")
		.details(.init(source: ["HTTP"], tags: ["Network"]))
		.configuration(.init([.switchHandler: "BaseNetworkUtil"]))
