import SwiftUI

struct GroupsTextModifier: ViewModifier {
	func body (content: Content) -> some View {
		content
			.font(.system(size: 14, weight: .light))
			.foregroundColor(UIColor.label.color)
	}
}

struct LecturerTextModifier: ViewModifier {
	func body (content: Content) -> some View {
		content
			.font(.system(size: 16, weight: .light))
			.foregroundColor(Color(white: 0.35))
	}
}

struct RoomTextModifier: ViewModifier {
	let font: Font
	
	init (fontSize: CGFloat) {
		font = .system(size: fontSize, weight: .light)
	}
	
	func body (content: Content) -> some View {
		content.font(font)
	}
}
