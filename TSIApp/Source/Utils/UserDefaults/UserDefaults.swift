import UserDefaultsUtil
import SwiftDate

extension MTUserDefaults {
	static let language = DefautableItem<FrontendLanguage, StandardDefaultValueProvider>("language", defaultValueProvider: .init(.system))
	
	static let dateTime =          DefautableItem<DateInRegion, DynamicDefaultValueProvider>("day", defaultValueProvider: .init({ DateInRegion() }))
	static let intervalType = DefautableItem<Schedule.IntervalType, StandardDefaultValueProvider>("intervalType", defaultValueProvider: .init(.day))
	
	static let group =    DefautableItem<SelectionModel, StandardDefaultValueProvider>("group", defaultValueProvider: .init(.empty))
	static let lecturer = DefautableItem<SelectionModel, StandardDefaultValueProvider>("lecturer", defaultValueProvider: .init(.empty))
	static let room =     DefautableItem<SelectionModel, StandardDefaultValueProvider>("room", defaultValueProvider: .init(.empty))
	
	static let groupsFilter =    DefautableItem<String, StandardDefaultValueProvider>("groupsFilter", defaultValueProvider: .init(""))
	static let lecturersFilter = DefautableItem<String, StandardDefaultValueProvider>("lecturersFilter", defaultValueProvider: .init(""))
	static let roomFilter =      DefautableItem<String, StandardDefaultValueProvider>("roomFilter", defaultValueProvider: .init(""))
}
