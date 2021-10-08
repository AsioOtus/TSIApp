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
	requestInfoConverter: StandardRequestInfoStringConverter().convert,
	urlRequestConverter: DefaultURLRequestStringConverter().convert,
	urlResponseConverter: DefaultURLResponseStringConverter().convert,
	httpUrlResponseConverter: DefaultHTTPURLResponseStringConverter().convert,
	controllerErrorConverter: StandardControllerErrorStringConverter(
		urlRequestConverter: DefaultURLRequestStringConverter().convert,
		urlErrorConverter: { $0.localizedDescription }
	).convert
)
extension StandardLogger: BaseNetworkUtil.ControllerLogHandler where Message == String, Details == StandardRecordDetails {
	public func log (_ logRecord: NetworkController.Logger.LogRecord<NetworkController.Logger.BaseDetails>) {
		log(level: .info, message: logRecord.convert(networkLogRecordStringConverter) + "\n-----", details: .init(tags: [String(describing: logRecord.details.name)]))
	}
}

let baseNetworkUtilLogger =
	StandardLogger(Logging.centralHandler, label: "Logger.Network")
		.details(.init(source: ["BaseNetworkUtil"], tags: ["Network"]))
		.configuration(.init([.switchHandler: "BaseNetworkUtil"]))
