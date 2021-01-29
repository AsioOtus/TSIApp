import Combine

extension Requests.TSI {
	public struct SerialController {
		public static let shared = SerialController()
		private init () { }
		
		private let requestQueue = DispatchQueue(label: "Networks.Requests.TSI.SerialController.requestQueue")
		
		private static var cancellables = Set<AnyCancellable>()
		
		public func send <RequestDelegate: TSIRequestDelegate> (_ requestDelegate: RequestDelegate) -> Future<RequestDelegate.Content, Error> {
			Future<RequestDelegate.Content, Error> { promise in
				self.requestQueue.async {
					let dispatchGroup = DispatchGroup()
					dispatchGroup.enter()
					
					Requests.TSI.Controller.shared.send(requestDelegate)
						.sink(
							receiveCompletion: { completion in
								dispatchGroup.leave()
								
								if case .failure(let error) = completion { promise(.failure(error))	}
							},
							receiveValue: { responseContent in
								promise(.success(responseContent))
							}
						)
						.store(in: &Self.cancellables)
						
					dispatchGroup.wait()
				}
			}
		}
	}
}
