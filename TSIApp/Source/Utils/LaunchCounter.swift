import Foundation

final class LaunchCounter {
	static let `default` = LaunchCounter("default")
	
	private static let launchCountKey = "launchCount"
	private static let cycleIdKey = "cycleId"
	
	private var prefixedLaunchCountKey: String { prefixed(Self.launchCountKey) }
	private var prefixedCycleIdKey: String { prefixed(Self.cycleIdKey) }
	
	let prefix: String
	
	var count: Int { UserDefaults.standard.integer(forKey: prefixedLaunchCountKey) }
	var isFirst: Bool { count == 1 }
	
	init (_ prefix: String) {
		assert(!prefix.isEmpty, "LaunchCounter – key can not be empty")
		
		self.prefix = prefix
	}
	
	func prefixed (_ key: String) -> String { "LaunchCounter.\(prefix).\(key)" }
	
	func launch () {
		UserDefaults.standard.set(count + 1, forKey: prefixedLaunchCountKey)
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
}
