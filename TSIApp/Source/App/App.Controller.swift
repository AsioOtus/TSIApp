import Combine
import BaseNetworkUtil
import NetworkUtil
import UserDefaultsUtil
import LoggingUtil



extension App {
	class Controller {
		static let current = Controller()
		private init () { }
		
		private var cancellables = Set<AnyCancellable>()
		
		let serialController = Controllers.Serial(settings: .init(controllers: .init(loggingProvider: baseNetworkUtilLogger)))
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
		serialController.send(TSI.Requests.GetItems.Delegate())
			.receive(on: DispatchQueue.main)
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
		
		serialController.send(TSI.Requests.GetItems.Delegate())
			.receive(on: DispatchQueue.main)
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
		configureUserDefaults()
		
		loadScheduleFilterValuesSets()
	}
	
	func configureUserDefaults () {
		UserDefaultsUtil.globalSettings =
			.init(
				items: .init(
					prefix: App.Info.current.identifier
				),
				logging: .init(
					enable: true,
					enableValuesLogging: true,
					level: .debug,
					loggingProvider: userDefaultUtilLogger
				)
			)
	}
}
