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
		
		let serialController = Serial(
			NetworkController()
				.logHandler(baseNetworkUtilLogger)
		)
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
		let cancellable = self.serialController.send(TSI.Requests.GetItems.Delegate())
			.delay(for: 10, scheduler: DispatchQueue.global(qos: .background))
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
		
		DispatchQueue.main.async {
			App.State.current.scheduleFilterValuesSets = .loading(cancellable)
		}
	}
}



private extension App.Controller {
	func configureApp () {
		loadScheduleFilterValuesSets()
		
		UserDefaultsUtil.DefaultInstances.storage = StandardStorage(keyPrefix: App.Info.current.identifier)
		UserDefaultsUtil.DefaultInstances.logHandler = userDefaultsUtilLogger
	}
}
