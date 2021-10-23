import SwiftUI

struct LoadingStateTokenView: View {
	@State var animated: Bool
	@State var color: Color = UIColor.tertiaryLabel.color
	
	init (animated: Bool = true) {
		self.animated = animated
	}
	
    var body: some View {
		RoundedRectangle(cornerRadius: 8, style: .continuous)
			.foregroundColor(color)
			.frame(maxWidth: 200)
			.frame(height: 20)
			.onAppear {
				guard animated else { return }
				
				withAnimation {
					color = UIColor.quaternaryLabel.color
				}
			}
			.animation(
				Animation
					.easeInOut(duration: 1)
					.repeatForever(autoreverses: true)
			)
    }
}
