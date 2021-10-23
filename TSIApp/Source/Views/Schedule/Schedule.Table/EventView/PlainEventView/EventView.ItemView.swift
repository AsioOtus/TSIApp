import SwiftUI

extension Schedule.Table.EventView {
	struct ItemView <TextViewModifier: ViewModifier>: View {
		let item: Schedule.Event.Info.Display.ItemState?
		let textModifier: TextViewModifier
		
		init (item: Schedule.Event.Info.Display.ItemState?, textModifier: TextViewModifier) {
			self.item = item
			self.textModifier = textModifier
		}
		
		var body: some View {
			switch item {
			case .value(let value):
				Text(value.value)
					.modifier(textModifier)
				
			case .notFound(let key):
				Text(key)
					.background(Color.red)
					.foregroundColor(Color.white)
				
			case .none:
				EmptyView()
			}
		}
	}
}
