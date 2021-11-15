import SwiftUI

extension Schedule.Table.EventView {
	struct GroupView: View {
		let groups: [Schedule.Event.Info.Display.ItemState]
		
		let columns = [
			GridItem(.adaptive(minimum: 70), spacing: 10)
		]
		
		var body: some View {
			LazyVGrid(columns: columns, alignment: .leading) {
				ForEach(groups, id: \.id) { group in
					ItemView(item: group, textModifier: GroupsTextModifier())
				}
			}
		}
	}
}
