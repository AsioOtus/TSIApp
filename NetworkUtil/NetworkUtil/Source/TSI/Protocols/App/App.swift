struct App {
	static let current = Self()
	private init () { }
	
	static var colorScheme: AppColorScheme { App.State.current.colorScheme }
}
