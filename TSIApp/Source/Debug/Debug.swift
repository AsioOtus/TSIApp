import Foundation
import SwiftDate



struct Debug { }



extension Debug {
	static let groups = [
		SelectionModel("1", "1001"),
		SelectionModel("2", "1002"),
		SelectionModel("3", "1003"),
		SelectionModel("4", "1004"),
		SelectionModel("5", "1005"),
	]
	
	static let group = SelectionModel("6", "1006")
	
	static let testDate: Date = {
		var dateComponents = DateComponents()
		dateComponents.year = 2020
		dateComponents.month = 9
		dateComponents.timeZone = TimeZone(abbreviation: "UTC")
		let selectedDate = Calendar.current.date(from: dateComponents)!
		
		return selectedDate
	}()
}



extension Debug {
	static func afterAppConfiguration () {
		test()
	}
	
	private static func test () {
		
	}
}
