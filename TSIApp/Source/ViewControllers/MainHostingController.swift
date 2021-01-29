import SwiftUI



class MainHostingController<Content>: UIHostingController<Content> where Content: View {
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
}
