import Foundation

public protocol Configurable { }

public extension Configurable {
	func use (in block: (Self) throws -> Void) rethrows {
		try block(self)
	}
	
	func useCopy (in block: (inout Self) throws -> Void) rethrows {
		var selfCopy = self
		try block(&selfCopy)
	}
	
	mutating func useSelf (in block: (inout Self) throws -> Void) rethrows {
		try block(&self)
	}
}

public extension Configurable {
	func set (in block: (inout Self) throws -> Void) rethrows -> Self {
		var selfCopy = self
		try block(&selfCopy)
		return selfCopy
	}
	
	mutating func setSelf (in block: (inout Self) throws -> Void) rethrows -> Self {
		try block(&self)
		return self
	}
}

public extension Configurable where Self: AnyObject {
	func set (in block: (Self) throws -> Void) rethrows -> Self {
		try block(self)
		return self
	}
}

public extension Configurable {
	func transform <T> (in block: (Self) throws -> T) rethrows -> T {
		let result = try block(self)
		return result
	}
}

extension NSObject: Configurable { }
