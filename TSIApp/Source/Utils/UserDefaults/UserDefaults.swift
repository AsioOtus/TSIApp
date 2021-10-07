import Foundation
import UserDefaultsUtil
import SwiftDate

extension UserDefaults {
	static let language = DefaultableItem<FrontendLanguage>("language", defaultValue: .system)
	
	static let dateTime =     DefaultableItem<DateInRegion>("dateTime", defaultValue: { DateInRegion() })
	static let intervalType = DefaultableItem<Schedule.IntervalType>("intervalType", defaultValue: .day)
	
	static let group =    DefaultableItem<SelectionModel>("group", defaultValue: .empty)
	static let lecturer = DefaultableItem<SelectionModel>("lecturer", defaultValue: .empty)
	static let room =     DefaultableItem<SelectionModel>("room", defaultValue: .empty)
	
	static let groupsFilter =    DefaultableItem<String>("groupsFilter", defaultValue: "")
	static let lecturersFilter = DefaultableItem<String>("lecturersFilter", defaultValue: "")
	static let roomFilter =      DefaultableItem<String>("roomFilter", defaultValue: "")
}
