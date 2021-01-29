import Foundation
import SwiftDate



extension Schedule.Table {
	struct Day {
		let date: DateInRegion
		
		var events: [Event]
		
		var isEmpty: Bool {	events.compactMap({ $0.displayEvent }).isEmpty }
		
		var displayWeekday: String { date.toFormat("eeee", locale: App.State.current.language.swiftDateLocale).capitalized }
		var displayDate: String { date.toFormat("d MMMM yyyy", locale: App.State.current.language.swiftDateLocale).capitalizedFirstLetter() }
		
		init (_ date: DateInRegion, _ displayEvents: [Schedule.Event.Display] = []) {
			self.date = date
			self.events = Event.Order.allEvents
			
			addEvents(displayEvents)
		}
		
		mutating func addEvents (_ displayEvents: [Schedule.Event.Display] = []) {
			var startIndex: Array<Schedule.Table.Day.Event>.Index = 0
			for displayEvent in displayEvents {
				guard let index = events[startIndex...].firstIndex(where: { $0.order.isInside(displayEvent.raw.date.dayTime) }) else { continue }
				events[index].displayEvent = .loaded(displayEvent)
				startIndex = index
			}
		}
	}
}
