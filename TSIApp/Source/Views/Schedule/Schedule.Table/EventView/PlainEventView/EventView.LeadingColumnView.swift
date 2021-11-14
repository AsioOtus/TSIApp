import SwiftUI

extension Schedule.Table.EventView {
	struct LeadingColumnView: View {
		let eventInfo: Schedule.Event.Info
		
		@EnvironmentObject var appState: App.State
		
		var body: some View {
			VStack (alignment: .trailing) {
				Text(eventInfo.date.dayTime.format("HH:mm"))
					.modifier(StartTimeTextModifier())
				
				Text(eventInfo.endTime.format("HH:mm"))
					.modifier(EndTimeTextModifier())
					.padding(.trailing, 2)
				
				Spacer()
					.frame(minHeight: 10, maxHeight: 25)
			}			
		}
	}
}
