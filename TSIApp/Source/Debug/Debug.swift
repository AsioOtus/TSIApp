import Foundation
import SwiftDate
import BaseNetworkUtil
import NetworkUtil
import Combine



struct Debug {
	static let isDebug: Bool = {
		#if DEBUG
		return true
		#else
		return false
		#endif
	}()
	
	static var cancellables = Set<AnyCancellable>()
}



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
		test3()
	}
	
	private static func test3 () {
		Logging.defaultLogger.info(Bundle.main.bundleIdentifier ?? "No Bundle identifier", details: .init(tags: ["QWW"]))
		Logging.defaultLogger.info(Bundle.main.resourcePath ?? "No Bundle identifier", details: .init(tags: ["QWW"]))
		Logging.defaultLogger.info(Bundle.main.bundlePath ?? "No Bundle identifier", details: .init(tags: ["QWW"]))
		
	}
	
	private static func test2 () {
		let a = [["08:45", "10:30", "12:30", "14:15", "16:00", "17:45", "18:15", "20:00"],
		 ["08:45", "10:25", "10:30", "12:25", "12:30", "14:05", "14:15", "15:40", "16:00", "16:25", "17:15", "17:45", "18:15", "18:50", "20:00"],
		 ["08:45", "10:30", "12:30", "14:15", "16:00", "18:15", "20:00"],
		 ["08:45", "10:30", "12:30", "14:15", "16:00", "17:45", "18:15", "19:30", "20:00"],
		 ["08:45", "10:30", "12:30", "14:15", "16:00", "17:45", "18:15", "19:30", "20:00"],
		 ["08:45", "10:30", "12:15", "12:30", "14:00", "14:15", "15:30", "16:00", "16:25", "17:45", "18:15", "19:30", "20:00"],
		 ["08:45", "10:30", "12:30", "14:15", "16:00", "17:45", "18:15", "20:00"]]
		
		let b = a.flatMap{ $0 }
		let c = Array(Set(b)).sorted(by: <)
		print(c)
	}
	
	private static func test () {
		NetworkController()
			.logHandler(baseNetworkUtilLogger.details(.init(tags: ["Kek"])))
			.send(TSI.Requests.GetLocalizedEvents.CustomDelegate(fromDate: .init(year: 2019, month: 2, day: 1), toDate: .init(year: 2019, month: 2, day: 15)))
			.sink(
				receiveCompletion: { completion in
					switch completion {
					case .finished:
						print("TTEST")
					case .failure(let error):
						print("TTEST", error)
					}
				},
				receiveValue: { events in
//					print("TTEST", events)
					
					let a = Array(Set(events.map{ $0.date.toFormat("HH:mm") })).sorted(by: <)
					print(a)
					
				}
			)
			.store(in: &cancellables)
	}
}
