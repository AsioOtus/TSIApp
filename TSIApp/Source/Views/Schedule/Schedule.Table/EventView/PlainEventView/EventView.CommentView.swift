import SwiftUI

extension Schedule.Table.EventView {
	struct CommentView: View {
		static let canceledSigns = ["cancel", "canceled", "atcelt", "отменено"]
		
		@EnvironmentObject var appState: App.State
		let eventInfo: Schedule.Event.Info
		
		var preparedComment: String {
			eventInfo.comment.trimmingCharacters(in: .whitespacesAndNewlines)
		}
		
		var backgroundColor: Color {
			Self.canceledSigns.contains(eventInfo.comment.lowercased()) ? Color.red : appState.colorScheme.eventCommentBackground.color
		}
		
		var foregroundColor: Color {
			Self.canceledSigns.contains(eventInfo.comment.lowercased()) ? Color.white : appState.colorScheme.eventCommentLabel.color
		}
		
		var body: some View {
			if !preparedComment.isEmpty {
				Text(preparedComment)
					.font(.system(size: 13))
					.italic()
					.fontWeight(.medium)
					.padding([.leading, .trailing], 6)
					.padding([.top, .bottom], 1)
					.fixedSize(horizontal: false, vertical: true)
					.background(backgroundColor)
					.foregroundColor(foregroundColor)
					.cornerRadius(5)
			}
		}
	}
}
