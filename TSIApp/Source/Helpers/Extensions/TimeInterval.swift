import Foundation
import SwiftDate

extension TimeInterval {
	func format (_ format: String) -> String {
		let date = DateInRegion(seconds: self)
		let time = date.toFormat(format)
		return time
	}
}
