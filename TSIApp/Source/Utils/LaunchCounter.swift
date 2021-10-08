import Foundation

final class LaunchCounter {
	static let `default` = LaunchCounter("default")
	
	private static let cycleIdKey = "cycleId"
	private static let launchCountKey = "launchCount"
	
	var prefixedCycleIdKey: String { prefixed(Self.cycleIdKey) }
	var prefixedLaunchCountKey: String { prefixed(Self.launchCountKey) }
	
	let label: String
	
	var count: Int { UserDefaults.standard.integer(forKey: prefixedLaunchCountKey) }
	var isFirst: Bool { count == 1 }
	
	init (_ label: String) {
		assert(!label.isEmpty, "LaunchCounter – key can not be empty")
		
		self.label = label
	}
	
	func prefixed (_ key: String) -> String { "LaunchCounter.\(label).\(key)" }
	
	func launch () {
		UserDefaults.standard.set(count + 1, forKey: prefixedLaunchCountKey)
	}
	
	func launch (cycle id: String) {
		next(cycle: id)
		launch()
	}
	
	func ifFirst (_ action: () -> Void) {
		guard count == 0 else { return }
		action()
	}
	
	func next (cycle id: String) {
		guard id != UserDefaults.standard.string(forKey: prefixedCycleIdKey) else { return }
		UserDefaults.standard.set(0, forKey: prefixedLaunchCountKey)
		UserDefaults.standard.set(id, forKey: prefixedCycleIdKey)
	}
	
	func resetCount () {
		UserDefaults.standard.set(0, forKey: prefixedLaunchCountKey)
	}
	
	func resetCycle () {
		UserDefaults.standard.set(nil, forKey: prefixedCycleIdKey)
	}
}
