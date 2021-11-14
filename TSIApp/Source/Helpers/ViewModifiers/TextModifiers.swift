import SwiftUI

struct StartTimeTextModifier: ViewModifier {
	func body (content: Content) -> some View {
		content
			.font(.system(size: 25, weight: .light))
	}
}

struct EndTimeTextModifier: ViewModifier {
	func body (content: Content) -> some View {
		content
			.font(.system(size: 18, weight: .light))
			.foregroundColor(UIColor.secondaryLabel.color)
	}
}

struct RoomTextModifier: ViewModifier {
	func body (content: Content) -> some View {
		content
	}
}

struct LectureNameTextModifier: ViewModifier {
	func body (content: Content) -> some View {
		content
	}
}

struct LecturerTextModifier: ViewModifier {
	func body (content: Content) -> some View {
		content
			.font(.system(size: 16, weight: .light))
			.foregroundColor(UIColor.secondaryLabel.color)
	}
}

struct GroupsTextModifier: ViewModifier {
	func body (content: Content) -> some View {
		content
			.font(.system(size: 12.5, weight: .light))
			.foregroundColor(UIColor.secondaryLabel.color)
	}
}
