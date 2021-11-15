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
				
				Section(header: Text(Local[.aboutTeamTitle])) {
					HStack {
						Text(Local[.aboutDeveloper])
						Spacer()
						Text(Local[.aboutDeveloperName])
							.foregroundColor(.secondary)
					}
				}
				
				Section(header: Text(Local[.aboutSupportTitle])) {
					Text(Local[.aboutReportABugDescription])
						.padding([.top, .bottom], 8)
					
					if MFMailComposeViewController.canSendMail() {
						Button(Local[.aboutReportABug]) {
							self.isShowingMailView = true
						}
						.foregroundColor(UIColor.systemRed.color)
						.frame(maxWidth: .infinity)
						.sheet(isPresented: $isShowingMailView) {
							MailView(recipients: ["support@tsi-app.lv"], subject: "[Issue] \(Local.shared.localize(Local.Keys.PreferencesView.aboutMailSubject.rawValue, Local.Keys.PreferencesView.tableName, .system))") { _, _, _ in
								isShowingMailView = false
							}
						}
					}
				}
			}
			.listStyle(InsetGroupedListStyle())
		}
	}
}
