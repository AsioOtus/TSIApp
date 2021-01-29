import SwiftUI


extension Schedule.Table {
	struct DayView: View {
		let day: Schedule.Table.Day
		
		var body: some View {
			Section (header: sectionHeaderView) {
				ForEach (day.events, id: \.order.startTime) { event in
					EventView(event: event)
				}
			}
		}
	}
}



extension Schedule.Table.DayView {
	private var sectionHeaderView: some View {
		HStack {
			Text(day.displayWeekday)
			Spacer()
			Text(day.displayDate)
		}
	}
}
