import SwiftUI

extension Schedule.Table {
	struct PlainDayView: View {
		let info: Schedule.Day.Info
		
		var body: some View {
			Section (header: sectionHeader) {
				if !info.events.isEmpty {
					ForEach (info.events, id: \.startTime) { event in
						EventView(event: event)
					}
				}
			}
		}
		
		var sectionHeader: some View {
			HStack {
				Text(info.date.toFormat("eeee", locale: App.State.current.language.swiftDateLocale).capitalized)
				Spacer()
				Text(info.date.toFormat("d MMMM yyyy", locale: App.State.current.language.swiftDateLocale).capitalizedFirstLetter())
			}
		}
	}
}
