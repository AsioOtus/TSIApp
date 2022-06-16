import UIKit
import MessageUI
import SwiftUI

extension Preferences {
	struct AboutView: View {
		@State var isShowingMailView = false
		
		var body: some View {
			List {
				Section(header: Text(Local[.aboutDescriptionTitle])) {
					Text(Local[.aboutDescription])
						.padding([.top, .bottom], 8)
				}
				
				Section {
					Text(Local[.aboutNotOfficial])
						.padding([.top, .bottom], 8)
					
					Button(Local[.aboutNotOfficialButtonText]) {
						if let url = URL(string: "itms-apps://apps.apple.com/lv/app/tsi-schedule/id606137492") {
							UIApplication.shared.open(url)
						}
					}
					.frame(maxWidth: .infinity)
				}
				
				Section {
					HStack {
						Text(Local[.aboutDeveloper])
						Spacer()
						Text(Local[.aboutDeveloperName])
							.foregroundColor(.secondary)
					}
				}
			}
			.listStyle(InsetGroupedListStyle())
		}
	}
}
