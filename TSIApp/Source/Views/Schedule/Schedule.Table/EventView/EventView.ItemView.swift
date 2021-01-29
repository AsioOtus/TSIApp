import SwiftUI

extension Schedule.Table.EventView {
	struct ItemView <TextViewModifier: ViewModifier>: View {
		let item: Schedule.Event.ItemState<SelectionModel>?
		let textModifier: TextViewModifier
		
		init (item: Schedule.Event.ItemState<SelectionModel>?, textModifier: TextViewModifier) {
			self.item = item
			self.textModifier = textModifier
		}
		
		var body: some View {
			switch item {
			case .value(let selectionModel):
				Text(selectionModel.value).modifier(textModifier)
				
			case .notFound(let key):
				Text(key)
					.background(Color.red)
					.foregroundColor(Color.white)
				
			case .none:
				EmptyView()
			}
		}
		
		var placeholderView: some View {
			Rectangle().size(width: 100, height: 20)
		}
	}
}
