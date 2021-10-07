import SwiftUI

struct EqualWidthPreferenceKey: PreferenceKey {
	static var defaultValue: CGFloat?
	static func reduce (value: inout CGFloat?, nextValue: () -> CGFloat?) {
		switch (value, nextValue()) {
		case (_, nil):
			break
		
		case let (nil, .some(nextValue)):
			value = nextValue
			
		case let (.some(previousValue), .some(nextValue)):
			value = max(previousValue, nextValue)
		}
	}
}

struct EqualWidth: ViewModifier {
	let width: CGFloat?
	let height: CGFloat?
	let alignment: Alignment
	
	init (width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) {
		self.width = width
		self.height = height
		self.alignment = alignment
	}
	
	func body (content: Content) -> some View {
		content
			.frame(width: width, height: height, alignment: alignment)
			.background(
				GeometryReader { proxy in
					Color.clear.preference(key: EqualWidthPreferenceKey.self, value: proxy.size.width)
				}
			)
	}
}

struct UpdateEqualWidthModifier: ViewModifier {
	@Binding var width: CGFloat?
	
	func body (content: Content) -> some View {
		content
			.onPreferenceChange(EqualWidthPreferenceKey.self) { value in
				var a = "\(width) \(value)"
				
				switch (width, value) {
				case (_, nil):
					break
					
				case let (nil, .some(nextValue)):
					width = nextValue
					
				case let (.some(previousValue), .some(nextValue)):
					width = max(previousValue, nextValue)
				}
				
				a += " – \(width)"
				
				Logging.defaultLogger.info(a, details: .init(tags: ["KEK"]))
			}
	}
}



extension View {
	func equalWidth (width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) -> some View {
		return modifier(EqualWidth(width: width, height: height, alignment: alignment))
	}
	
	func updateEqualWidth (_ width: Binding<CGFloat?>) -> some View {
		return modifier(UpdateEqualWidthModifier(width: width))
	}
}
