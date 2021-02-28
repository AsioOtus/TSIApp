import LoggingUtil

extension DefaultLogHandler {
	static let standard = DefaultLogHandler(
		sourcePrefix: App.Info.current.shortIdentifier,
		levelPadding: true,
		stringLogExporter: LoggerFrameworkLogExporter(),
		loggerInfo: .init(level: .info),
		enabling: .init(tags: true)
	)
}
