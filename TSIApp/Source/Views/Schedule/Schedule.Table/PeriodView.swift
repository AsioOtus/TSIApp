import SwiftUI

extension Schedule.Table {
	struct PeriodView: View {
		@EnvironmentObject var appState: App.State
		@ObservedObject var vm: ViewModel
		
		@State var leadingColumnWidth: CGFloat?
		
		var body: some View {
			switch vm.days {
			case .notInitialized:
				Text("Refresh")
				
			case .loading:
				List {
					EmptyDayView2(startDate: vm.period.startDate, endDate: vm.period.endDate)
				}
				.environment(\.defaultMinListRowHeight, 10)
				.listStyle(InsetGroupedListStyle())
				
			case .loaded(let days):
				List {
					ForEach(days, id: \.date) { day in
						Schedule.Table.DayView(day: day)
							.environment(\.leadingColumnWidth, leadingColumnWidth)
					}
				}
				.environment(\.defaultMinListRowHeight, 10)
				.listStyle(InsetGroupedListStyle())
				
			case .failed(let error):
				Text(String(describing: error))
			}
		}
	}
}

extension Schedule.Table.PeriodView {
	struct LeadingColumnWidthEnvironmentKey: EnvironmentKey {
		static let defaultValue: CGFloat? = nil
	}
}

extension EnvironmentValues {
	var leadingColumnWidth: CGFloat? {
		get { self[Schedule.Table.PeriodView.LeadingColumnWidthEnvironmentKey.self] }
		set { self[Schedule.Table.PeriodView.LeadingColumnWidthEnvironmentKey.self] = newValue }
	}
}
