import LoggingUtil

struct Logging {
	static let defaultExporter = OSLogExporter(label: "Exporter.Default")
	
	static let centralHandler = SwitchHandler(label: "Handler.Central")
		.details(.init(source: [App.Info.current.shortIdentifier]))
		.handler(
			key: "UserDefaultsUtil",
			PlainConnector(
				converter:
					SingleLineConverter(label: "Converter.SingleLine")
						.detailsEnabling(.enabled(tags: false))
						.metaInfoEnabling(.enabled(level: false)),
				exporter:
					defaultExporter
			)
		)
		.handler(
			key: "BaseNetworkUtil",
			StandardHandler {
				PlainConnector(MultilineConverter())
					.exporter(defaultExporter)
					.isEnabled(false)
					.eraseToAnyHandler()
			
				PlainConnector(SingleLineConverter())
					.exporter(defaultExporter)
					.eraseToAnyHandler()
			}
		)
		.defaultHandler(
			PlainConnector(
				converter: MultilineConverter(label: "Converter.Multiline"),
				exporter: defaultExporter
			)
		)
	
	static let defaultLogger = StandardLogger(centralHandler, label: "Logger.Default")
}
