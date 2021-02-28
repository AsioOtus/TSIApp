import Foundation
import UserDefaultsUtil
import SwiftDate

extension UserDefaults {
	static let language = DefaultableItem<FrontendLanguage, StaticDefaultValueProvider>("language", .init(.system))
	
	static let dateTime =     DefaultableItem<DateInRegion, DynamicDefaultValueProvider>("day", .init(DateInRegion()))
	static let intervalType = DefaultableItem<Schedule.IntervalType, StaticDefaultValueProvider>("intervalType", .init(.day))
	
	static let group =    DefaultableItem<SelectionModel, StaticDefaultValueProvider>("group", .init(.empty))
	static let lecturer = DefaultableItem<SelectionModel, StaticDefaultValueProvider>("lecturer", .init(.empty))
	static let room =     DefaultableItem<SelectionModel, StaticDefaultValueProvider>("room", .init(.empty))
	
	static let groupsFilter =    DefaultableItem<String, StaticDefaultValueProvider>("groupsFilter", .init(""))
	static let lecturersFilter = DefaultableItem<String, StaticDefaultValueProvider>("lecturersFilter", .init(""))
	static let roomFilter =      DefaultableItem<String, StaticDefaultValueProvider>("roomFilter", .init(""))
}
