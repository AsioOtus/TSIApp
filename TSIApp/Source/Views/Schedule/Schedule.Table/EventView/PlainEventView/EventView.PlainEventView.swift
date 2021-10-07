import SwiftUI

extension Schedule.Table.EventView {
	struct PlainEventView: View {
		let eventInfo: Schedule.Event.Info
		
		var body: some View {
			HStack (alignment: .top) {
				LeadingColumnView(eventInfo: eventInfo)
				Divider()
				PrimaryColumnView(eventInfo: eventInfo)
			}
		}
	}
}
