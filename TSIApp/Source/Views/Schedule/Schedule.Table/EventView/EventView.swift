import SwiftUI
import Combine

extension Schedule.Table {
	struct EventView: View {
		let event: Schedule.Event
		
		var body: some View {
			switch event {
			case .empty:
				EmptyEventView(event: event)
					.listRowBackground(Color(white: 0.98))
				
			case .plain(let eventInfo):
				PlainEventView(eventInfo: eventInfo)
			}
		}
	}
}
