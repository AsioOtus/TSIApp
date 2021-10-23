import SwiftUI

extension Schedule.Table.EventView {
	struct PrimaryColumnView: View {
		let eventInfo: Schedule.Event.Info
		@EnvironmentObject var appState: App.State
		
		var body: some View {
			VStack (alignment: .leading) {
				if let name = eventInfo.name {
					Text(name)
						.font(.callout)
				}
				
				switch eventInfo.display {
				case .notInitialized:
					placeholderView("Lecturer not init", .gray)
						.padding(.top, 5)
					
				case .loading:
					LoadingStateTokenView()
					
				case .loaded(let displayInfo):
					if appState.lecturer == .empty {
						ItemView(item: displayInfo.lecturer, textModifier: LecturerTextModifier())
							.padding(.top, 1)
					}
					
					if isGroupsShown(displayInfo.groups) {
						HStack {
							ForEach(displayInfo.groups, id: \.id) { group in
								ItemView(item: group, textModifier: GroupsTextModifier())
							}
						}
						.padding(.top, 1)
					}
					
				case .failed(_):
					Text(Local[.loadingError])
						.foregroundColor(.red)
						.font(.footnote)
						.padding(.top, 1)
				}
				
				CommentView(eventInfo: eventInfo)
					.padding(.top, 3)
			}
			.padding(.bottom, 10)
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
