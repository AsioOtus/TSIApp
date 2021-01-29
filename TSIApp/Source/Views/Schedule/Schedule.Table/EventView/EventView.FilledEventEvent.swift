import SwiftUI

extension Schedule.Table.EventView {
	struct FilledEventView: View {
		let event: Schedule.Table.Day.Event
		
		var body: some View {
			VStack (alignment: .leading) {
				HStack (alignment: .top) {
					LeftColumnViewB(event: event)
					Divider()
					
					switch event.displayEvent {
					case .loaded(.some(let displayEvent)):
						PrimaryColumnViewB(event: displayEvent)
						Spacer(minLength: 5)
						RightColumnViewB(event: displayEvent)
					case .loaded(.none):
						EmptyView()
					case .loading:
						EmptyView()
					case .failed:
						EmptyView()
					case .notInitialized:
						EmptyView()
					}
				}
			}
		}
	}
}
