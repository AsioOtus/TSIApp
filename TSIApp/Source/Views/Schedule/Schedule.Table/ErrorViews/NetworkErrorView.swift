import SwiftUI
import BaseNetworkUtil

extension Schedule.Table {
	struct NetworkErrorView: View {
		let error: NetworkController.Error
		
		var body: some View {
			switch error {
			case .preprocessingFailure: processingFailure
			case .networkFailure: networkFailure
			case .postprocessingFailure: processingFailure
			}
		}
		
		var processingFailure: some View {
			Text(Local[.internalNetworkError])
		}
		
		var networkFailure: some View {
			VStack {
				Text(Local[.noConnectionHeader])
					.font(.title)
				Text(Local[.noConnectionText])
					.font(.caption)
				
				Button(Local[.retry]) {
					
				}
			}
			.multilineTextAlignment(.center)
		}
	}
}
