import SwiftUI
import SwiftDate

extension Schedule.Table {
	struct DayView: View {
		let day: Schedule.Day
		
		var body: some View {
			switch day {
			case .plain(let info):
				PlainDayView(info: info)

			case let .empty(startDate, endDate):
				MessageView(startDate, endDate) { EmptyView() }
			}
		}
	}
}
