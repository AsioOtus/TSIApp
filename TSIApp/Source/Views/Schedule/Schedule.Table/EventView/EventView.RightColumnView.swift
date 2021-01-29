import SwiftUI



extension Schedule.Table.EventView {
	struct RightColumnViewA: View {
		let event: Schedule.Event.Display
		
		var body: some View {
			VStack (alignment: .leading) {
				ItemsView(items: event.groups, textModifier: GroupsTextModifier())
			}
			.background(Color.red)
			.frame(maxWidth: 80)
			.background(Color.green)
		}
	}
}



extension Schedule.Table.EventView {
	struct RightColumnViewB: View {
		let event: Schedule.Event.Display
		
		var body: some View {
			HStack (alignment: .center) {
				ItemsView(items: event.rooms, textModifier: RoomTextModifier(fontSize: 18))
			}
			.frame(maxHeight: .infinity)
		}
	}
}
