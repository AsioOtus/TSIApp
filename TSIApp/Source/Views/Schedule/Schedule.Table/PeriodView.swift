import SwiftUI

extension Schedule.Table {
	struct PeriodView: View {
		@EnvironmentObject var appState: App.State
		@ObservedObject var vm: ViewModel
		
		@State var leadingColumnWidth: CGFloat?
		
		var body: some View {
			switch vm.days {
			case .notInitialized:
				List {
					MessageView(vm.period.startDate, vm.period.endDate, showDuration: false) {
						Button(Local[.refresh]) {
							vm.refresh()
						}
					}
				}
				.environment(\.defaultMinListRowHeight, 10)
				.listStyle(InsetGroupedListStyle())
				
			case .loading:
				List {
					MessageView(vm.period.startDate, vm.period.endDate, showDuration: false) {
						Spacer()
						
						Text(Local[.loading])
						ProgressView()
							.padding(.top, 8)
							.scaleEffect(1.25, anchor: .center)
					}
				}
				.environment(\.defaultMinListRowHeight, 10)
				.listStyle(InsetGroupedListStyle())
				
			case .loaded(let days):
				List {
					ForEach(days, id: \.date) { day in
						Schedule.Table.DayView(day: day)
					}
				}
				.environment(\.defaultMinListRowHeight, 10)
				.listStyle(InsetGroupedListStyle())
				
			case .failed(let error):
				ErrorView(error: error)
			}
		}
	}
}
