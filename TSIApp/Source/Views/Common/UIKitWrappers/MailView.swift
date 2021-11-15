import UIKit
import MessageUI
import SwiftUI

struct MailView: UIViewControllerRepresentable {
	let recipients: [String]
	let subject: String
	let completion: (MFMailComposeViewController, MFMailComposeResult, Error?) -> Void
	
	func makeUIViewController (context: Context) -> MFMailComposeViewController {
		let mailVC = MFMailComposeViewController()
		
		mailVC.mailComposeDelegate = context.coordinator
		mailVC.setToRecipients(recipients)
		mailVC.setSubject(subject)
		
		return mailVC
	}
	
	func updateUIViewController (_ uiViewController: MFMailComposeViewController, context: Context) { }
}

extension MailView {
	func makeCoordinator () -> Coordinator { .init(completion) }
	
	class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
		let completion: (MFMailComposeViewController, MFMailComposeResult, Error?) -> Void
		
		init (_ completion: @escaping (MFMailComposeViewController, MFMailComposeResult, Error?) -> Void) {
			self.completion = completion
		}
		
		func mailComposeController (_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
			completion(controller, result, error)
		}
	}
}
