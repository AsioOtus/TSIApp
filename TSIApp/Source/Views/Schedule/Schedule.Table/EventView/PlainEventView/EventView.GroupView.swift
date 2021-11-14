import SwiftUI

extension Schedule.Table.EventView {
	struct GroupView: View {
		let groups: [Schedule.Event.Info.Display.ItemState]
		
		let columns = [
			GridItem(.flexible(minimum: 10, maximum: 100), spacing: 8, alignment: .leading),
			GridItem(.flexible(minimum: 10, maximum: 100), spacing: 8, alignment: .leading),
			GridItem(.flexible(minimum: 10, maximum: 100), spacing: 8, alignment: .leading),
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
