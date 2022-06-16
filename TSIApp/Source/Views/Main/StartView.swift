import SwiftUI

extension Main {
	struct StartView: View {
		@EnvironmentObject var appState: App.State
		
		var body: some View {
			GeometryReader { g in
				ZStack {
					appState.colorScheme.main.color
						.ignoresSafeArea()
					
					Image(uiImage: .logoWhite)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: g.size.width * 0.35)
				}
			}
		}
	}
}
