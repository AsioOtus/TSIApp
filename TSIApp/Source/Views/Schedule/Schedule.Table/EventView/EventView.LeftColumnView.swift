import SwiftUI

extension Schedule.Table.EventView {
	struct LeftColumnViewA: View {
		let event: Schedule.Table.Day.Event
		
		var body: some View {
			VStack (alignment: .center) {
				VStack (alignment: .center) {
					Text(event.order.startTime.format("HH:mm"))
						.font(.system(size: 25, weight: .light))
					Text(event.order.endTime.format("HH:mm"))
						.foregroundColor(Color(white: 0.45))
						.fontWeight(.thin)
				}
				HStack {
//					ItemsView(items: event.displayEvent?.rooms, textModifier: RoomTextModifier(fontSize: 16))
//						.padding([.top], 20)
				}
			}
			.frame(width: 70)
		}
	}
}



extension Schedule.Table.EventView {
	struct LeftColumnViewB: View {
		let event: Schedule.Table.Day.Event
		
		var body: some View {
			VStack (alignment: .center) {
				VStack (alignment: .trailing) {
					Text(event.order.startTime.format("HH:mm"))
						.font(.system(size: 25, weight: .light))
					
					Text(event.order.endTime.format("HH:mm"))
						.foregroundColor(Color(white: 0.6))
						.fontWeight(.light)
						.padding(.trailing, 2)
				}
			}
			.frame(width: 70)
		}
	}
}
