import Combine
import Networks
import UserDefaultsUtil
import Log



extension App {
	class Controller {
		static let current = Controller()
		private init () { }
		
		private var cancellables = Set<AnyCancellable>()
	}
}



extension App.Controller {
	func handleApplicationStart () {		
		configureApp()
		
		Debug.afterAppConfiguration()
	}
}



extension App.Controller {
	func loadScheduleFilterValuesSets () {
		Requests.TSI.SerialController.shared.send(Requests.TSI.GetItems.Delegate())
			.sink(
				receiveCompletion: { completion in
					if case let .failure(error) = completion {
						App.State.current.scheduleFilterValuesSets = .failed(error)
					}
				},
				receiveValue: {	valuesSets in
					App.State.current.scheduleFilterValuesSets = .loaded(valuesSets)
				}
			)
			.store(in: &cancellables)
		
		App.State.current.scheduleFilterValuesSets = .loading
	}
}



private extension App.Controller {
	func configureApp () {
		configureLogging()
		configureUserDefaults()
		
		loadScheduleFilterValuesSets()
	}
	
	func configureLogging () {
		Log.default.settings = .init(prefix: App.Info.current.name)
	}
	
	func configureUserDefaults () {
		MTUserDefaults.settings = .init(items:
			.init(
				itemKeyPrefixProvider: App.Info.current.identifier,
				logging: .init(
					enable: true,
					level: .default,
					enableValuesLogging: true,
					loggingProvider: MTUserDefaults.StandardLoggingProvider(prefix: App.Info.current.name)
				)
			)
		)
	}
}
