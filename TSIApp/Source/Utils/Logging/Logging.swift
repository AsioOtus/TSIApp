import LoggingUtil

struct Logging {
	static let defaultExporter = OSLogExporter(label: "Exporter.Default")
	
	static let centralHandler = SwitchHandler(label: "Handler.Central")
		.details(.init(source: [App.Info.current.shortIdentifier]))
		.handler(
			key: "UserDefaults",
			PlainConnector(SingleLineConverter(label: "Converter.SingleLine"))
				.exporter(defaultExporter)
		)
		.defaultHandler(
			PlainConnector(MultilineConverter(label: "Converter.Multiline"))
				.exporter(defaultExporter)
		)
	
	static let defaultLogger = StandardLogger(centralHandler, label: "Logger.Default")
}
