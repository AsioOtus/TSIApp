import SwiftUI

extension Schedule.Table.EventView {
	struct PrimaryColumnView: View {
		let eventInfo: Schedule.Event.Info
		@EnvironmentObject var appState: App.State
		
		var body: some View {
			VStack (alignment: .leading, spacing: 0) {
				HStack(alignment: .firstTextBaseline, spacing: 8) {
					Text(eventInfo.name)
						.fixedSize(horizontal: false, vertical: true)
						.font(.callout)
					
					Spacer()
					
						if appState.room.value.isEmpty {
						ItemsView(items: eventInfo.display.map{ $0.rooms }, textModifier: RoomTextModifier())
							.padding(.trailing, 2)
						}
				}
				.padding(.top, 7.5)
				
				Group {
					switch eventInfo.display {
					case .notInitialized:
						placeholderView("Lecturer not init", .gray)
						
					case .loading:
						LoadingStateTokenView()
						
					case .loaded(let displayInfo):
						if isLecturerShown(appState.lecturer) {
							ItemView(item: displayInfo.lecturer, textModifier: LecturerTextModifier())
								.padding(.top, 4)
						}
						
						if isGroupsShown(displayInfo.groups) {
							GroupView(groups: displayInfo.groups)
								.padding(.top, 8)
								
						}
						
					case .failed(_):
						Text(Local[.loadingError])
							.foregroundColor(.red)
							.font(.footnote)
					}
					
					CommentView(eventInfo: eventInfo)
						.padding(.top, 8)
				}
				.padding(.leading, 1)
			}
		}
		
		func isGroupsShown (_ groups: [Schedule.Event.Info.Display.ItemState]) -> Bool {
			!groups.isEmpty
				&&
				!(
					groups.count == 1
					&&
					groups.first!.id == App.State.current.group.key
				)
		}
		
		func isLecturerShown (_ lecturer: SelectionModel) -> Bool {
			lecturer == .empty
		}
		
		func placeholderView (_ text: String, _ color: Color) -> some View {
			Text(text)
				.padding(.leading, 5)
				.padding(.trailing, 5)
				.background(
					RoundedRectangle(cornerRadius: 8, style: .continuous)
						.foregroundColor(color)
				)
		}
	}
}
