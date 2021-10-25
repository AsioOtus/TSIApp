import UIKit
import MessageUI
import SwiftUI

extension Preferences {
	struct AboutView: View {
		@State var result: Result<MFMailComposeResult, Error>? = nil
		@State var isShowingMailView = false
		
		var body: some View {
			List {
				Section(header: Text(Local[.aboutDescriptionTitle])) {
					Text(Local[.aboutDescription])
				}
				
				Section {
					Text(Local[.aboutNotOfficial])
					
					Button(Local[.aboutNotOfficialButtonText]) {
						if let url = URL(string: "itms-apps://apps.apple.com/lv/app/tsi-schedule/id606137492") {
							UIApplication.shared.open(url)
						}
					}
					.frame(maxWidth: .infinity)
				}
				
				Section(header: Text(Local[.aboutTeamTitle])) {
					HStack {
						Text(Local[.aboutDeveloper])
						Spacer()
						Text(Local[.aboutDeveloperName])
							.foregroundColor(.secondary)
					}
				}
				
//				TODO: Add support section with new email and mail view
//
//				Section(header: Text(Local[.aboutSupportTitle])) {
//					Text(Local[.reportABugDescription])
//
//					Button(Local[.reportABug]) {
//						self.isShowingMailView = true
//					}
//					.foregroundColor(UIColor.systemRed.color)
//					.frame(maxWidth: .infinity)
//					.sheet(isPresented: $isShowingMailView) {
//						MailView(result: self.$result)
//					}
//				}
			}
			.listStyle(InsetGroupedListStyle())
		}
	}
}
