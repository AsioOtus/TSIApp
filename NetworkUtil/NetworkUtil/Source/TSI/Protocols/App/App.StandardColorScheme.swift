import UIKit

extension App {
	struct StandardColorScheme: AppColorScheme {
		let main = UIColor.from(resource: "tsiapp-main")
		let errorMessageBackground = UIColor.from(resource: "tsiapp-errorBackground")
		let secondaryText = UIColor.secondaryLabel
		let eventCommentBackground = UIColor.systemGray4
	}
}
