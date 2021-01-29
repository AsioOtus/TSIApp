import Foundation



extension DispatchQueue {
	static func label (_ label: String) -> String {
		guard !label.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { fatalError("Dispatch queue label cannot be empty") }
		let label = "\(App.Info.current.identifier).\(label)"
		return label
	}
	
	static func instanceLabel (_ label: String) -> String {
		"\(Self.label(label)).\(UUID().uuidString)"
	}
	
	static func instanceLabel (_ label: String, id: String) -> String {
		guard !id.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { fatalError("Dispatch queue label cannot be empty") }
		return "\(Self.label(label)).\(id)"
	}
	
	convenience init (instanceLabel: String) {
		self.init(label: Self.instanceLabel(instanceLabel))
	}
}



extension DispatchQueue {
	func delay (seconds: Double, block: @escaping () -> ()) {
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: block)
	}
}
