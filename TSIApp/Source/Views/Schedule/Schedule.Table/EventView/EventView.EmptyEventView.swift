import SwiftUI

extension Schedule.Table.EventView {
	struct EmptyEventView: View {
		let event: Schedule.Table.Day.Event
		
		var body: some View {
			HStack(alignment: .bottom) {
				Text(event.order.startTime.format("HH:mm"))
					.font(.system(size: 25, weight: .light))
					.foregroundColor(Color(white: 0.75))
				Text(event.order.endTime.format("HH:mm"))
					.foregroundColor(Color(white: 0.75))
					.fontWeight(.light)
					.padding(.leading, -3)
					.padding(.bottom, 0.5)
			}
		}
	}
}
