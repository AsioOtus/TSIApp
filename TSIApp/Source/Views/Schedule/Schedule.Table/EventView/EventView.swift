import SwiftUI



extension Schedule.Table {
	struct EventView: View {
		let event: Schedule.Table.Day.Event
		
		var body: some View {
			EmptyEventView(event: event)
//			switch event.displayEvent {
//			case .loaded(.some):
//				FilledEventView(event: event)
//			case .loaded(.none):
//				EmptyEventView(event: event)
//			case .loading:
//				EmptyView()
//			case .failed(let error):
//				EmptyView()
//			case .notInitialized:
//				EmptyEventView(event: event)
//			}
		}
	}
}
