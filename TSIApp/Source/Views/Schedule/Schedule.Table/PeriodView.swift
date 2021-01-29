import SwiftUI



struct PeriodView: View {
	var period: Schedule.Table.Period
	
	var body: some View {
		switch period.loadingState {
		case .failed(let error):
			Text("FAIL, AHAHAHAHA – \(error.localizedDescription)")
			
		default:
			List {
//				ForEach(period.days, id: \.date) { day in
//					Schedule.Table.DayView(day: day)
//				}
			}
			.listStyle(InsetListStyle())
		}
	}
}
