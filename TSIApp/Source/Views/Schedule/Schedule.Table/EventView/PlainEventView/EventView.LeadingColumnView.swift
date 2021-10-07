import SwiftUI

extension Schedule.Table.EventView {
	struct LeadingColumnView: View {
		let eventInfo: Schedule.Event.Info
		
		@EnvironmentObject var appState: App.State
		
		var body: some View {
			VStack (alignment: .trailing) {
				Text(eventInfo.date.dayTime.format("HH:mm"))
					.font(.system(size: 25, weight: .light))
				
				Text(eventInfo.endTime.format("HH:mm"))
					.foregroundColor(Color(white: 0.6))
					.fontWeight(.light)
					.padding(.trailing, 2)
				
				Spacer()
					.frame(minHeight: 15, maxHeight: 25)
				
				if appState.room.value.isEmpty {
					ItemsView(items: eventInfo.display.map{ $0.rooms }, textModifier: RoomTextModifier(fontSize: 16))
						.padding(.bottom, 10)
				}
			}
			.frame(width: 70)
		}
	}
}
