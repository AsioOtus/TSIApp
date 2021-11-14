import SwiftUI

extension Schedule.Table.EventView {
	struct PlainEventView: View {
		let eventInfo: Schedule.Event.Info
		
		var body: some View {
			HStack (alignment: .top, spacing: 10) {
				LeadingColumnView(eventInfo: eventInfo)
					.frame(width: 70, alignment: .trailing)
					.padding(.bottom, 2)
				
				Divider()
				
				PrimaryColumnView(eventInfo: eventInfo)
					.padding(.bottom, 2)
			}
		}
	}
}
