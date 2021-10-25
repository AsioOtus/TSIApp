import SwiftUI
import SwiftDate

extension Schedule.Table.EventView {
	struct EmptyEventView: View {
		let event: Schedule.Event
		
		@EnvironmentObject var appState: App.State
		
		var formattedDuration: String {
			event.duration.toString {
				$0.allowedUnits = [.hour, .minute]
				$0.unitsStyle = .full
				$0.locale = appState.language.swiftDateLocale
			}
		}
		
		var body: some View {
			HStack(alignment: .firstTextBaseline) {
				Text(event.startTime.format("HH:mm"))
					.font(.system(size: 20, weight: .light))
				
				Text(event.endTime.format("HH:mm"))
					.font(.system(size: 15, weight: .light))
					.padding(.leading, -3)
					.padding(.bottom, 2)
				
				Spacer()
				
				Text(formattedDuration)
					.font(.system(size: 15, weight: .light))
					.padding(.bottom, 2)
			}
			.listRowBackground(appState.colorScheme.emptyEventBackground.color)
			.foregroundColor(Color(white: 0.75))
		}
	}
}
