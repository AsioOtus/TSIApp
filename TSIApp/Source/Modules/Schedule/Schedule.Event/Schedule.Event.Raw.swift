import Foundation
import SwiftDate

extension Schedule.Event {
	struct Raw {
		let date: DateInRegion
		let groups: [String]
		let lecturer: String
		let rooms: [String]
		let name: String
		let comment: String
		let `class`: Class?
	}
}
