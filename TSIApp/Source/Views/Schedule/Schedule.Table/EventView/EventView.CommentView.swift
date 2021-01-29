import SwiftUI

extension Schedule.Table.EventView {
	struct CommentView: View {
		let event: Schedule.Event.Display
		
		var body: some View {
			if !event.raw.comment.isEmpty {
//				VStack (alignment: .leading) {
				Text(event.raw.comment)
					.font(.system(size: 13))
					.italic()
					.padding([.top, .bottom], 4)
					.padding([.leading, .trailing], 6)
//					.background(Color(white: 0.9))
					.background(App.colorScheme.eventCommentBackground.color)
//					.foregroundColor(.init(white: 0.3))
					.foregroundColor(.white)
					.cornerRadius(5)
//				}
//				.frame(maxWidth: .infinity)
			}
		}
	}
}
