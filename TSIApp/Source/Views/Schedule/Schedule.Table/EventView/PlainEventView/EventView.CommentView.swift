import SwiftUI

extension Schedule.Table.EventView {
	struct CommentView: View {
		let eventInfo: Schedule.Event.Info
		
		var preparedComment: String {
			eventInfo.comment.trimmingCharacters(in: .whitespacesAndNewlines)
		}
		
		var body: some View {
			if !preparedComment.isEmpty {
				Text(preparedComment)
					.font(.system(size: 13))
					.italic()
					.padding([.leading, .trailing], 6)
					.background(App.colorScheme.eventCommentBackground.color)
					.foregroundColor(.white)
					.cornerRadius(5)
			}
		}
	}
}
