import Foundation

class OncePerformer {
	private let actionQueue = DispatchQueue(instanceLabel: "OncePerformer.actionQueue")
	private var isPerformed = false
	
	func perform (_ action: () -> ()) {
		actionQueue.sync {
			guard !isPerformed else { return }
			
			isPerformed = true
			
			action()
		}
	}
}
