import SwiftUI

extension Schedule.Table.EventView {
	struct PrimaryColumnViewA: View {
		let event: Schedule.Event.Display
		
		var body: some View {
			VStack (alignment: .leading) {
				if let name = event.raw.name {
					Text(name)
						.font(.system(size: 16))
						.fontWeight(.medium)
				}
				
				switch event.lecturer {
				case .notInitialized:
					placeholderView.background(Color.green)
					
				case .loading:
					placeholderView.background(Color.gray)
					
				case .loaded(let lecturer):
					ItemView(item: lecturer, textModifier: LecturerTextModifier())
					
				case .failed(_):
					placeholderView.background(Color.red)
				}
				
				HStack {
					ItemsView(items: event.groups, textModifier: GroupsTextModifier())
						.padding([.top], 5)
				}
			}
		}
		
		var placeholderView: some View {
			Rectangle().size(width: 100, height: 20)
		}
	}
}



extension Schedule.Table.EventView {
	struct PrimaryColumnViewB: View {
		let event: Schedule.Event.Display
		
		var body: some View {
			HStack (alignment: .top) {
				VStack (alignment: .leading) {
					if let name = event.raw.name {
						Text(name)
							.font(.system(size: 16))
							.fontWeight(.medium)
					} else {
						
					}
					
					switch event.lecturer {
					case .notInitialized:
						placeholderView.background(Color.green).padding(.top, 5)
						
					case .loading:
						placeholderView.background(Color.gray).padding(.top, 5)
						
					case .loaded(let lecturer):
						ItemView(item: lecturer, textModifier: LecturerTextModifier()).padding(.top, 5)
						
					case .failed(_):
						placeholderView.background(Color.red).padding(.top, 5)
					}
					
					Spacer(minLength: 5)
					CommentView(event: event)
						.padding([.top, .bottom], 10)
				}
			}
		}
		
		var placeholderView: some View {
			Rectangle().size(width: 100, height: 20)
		}
	}
}
