import SwiftUI

struct TextFieldClearButtonModifier: ViewModifier {
	@Binding var text: String
	
	func body (content: Content) -> some View {
		HStack {
			content
			
			if !text.isEmpty {
				Button(
					action: { self.text = "" },
					label: {
						Image(systemName: "xmark.circle.fill")
							.foregroundColor(Color(UIColor.separator))
					}
				)
			}
		}
	}
}

extension View {
	func clearButton (_ text: Binding<String>) -> some View {
		modifier(TextFieldClearButtonModifier(text: text))
	}
}
