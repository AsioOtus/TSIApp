import SwiftUI
import BaseNetworkUtil

extension Schedule.Table {
	struct ErrorView: View {
		let error: Swift.Error
		
		var body: some View {
			switch error {
			case let networkError as NetworkController.Error: NetworkErrorView(error: networkError)
			default: defaultError(error)
			}
		}
		
		func defaultError (_ error: Swift.Error) -> some View {
			Text(Local[.unexpectedError])
		}
	}
}
