import UIKit

extension App {
	struct ColorScheme: AppColorScheme {
		let main = UIColor.from(resource: "Main")
		let errorMessageBackground = UIColor.from(resource: "ErrorBackground")
		let secondaryText = UIColor.from(resource: "SecondaryText")
		let eventCommentBackground = UIColor.from(resource: "EventCommentBackground")
	}
}
