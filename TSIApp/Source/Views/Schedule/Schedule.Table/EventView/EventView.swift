import SwiftUI
import Combine

extension Schedule.Table {
	struct EventView: View {
		let event: Schedule.Event
		
		var body: some View {
			switch event {
			case .empty:
				EmptyEventView(event: event)
				
			case .plain(let eventInfo):
				PlainEventView(eventInfo: eventInfo)
			}
		}
	}
}
