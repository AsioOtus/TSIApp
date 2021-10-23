import SwiftUI
import SwiftDate

extension Schedule.Table {
	struct MessageView <Content: View>: View {
		@EnvironmentObject var appState: App.State
		
		let startDate: DateInRegion
		let endDate: DateInRegion
		
		let showDuration: Bool
		
		var duration: TimeInterval {
			endDate - startDate + 1.days.timeInterval
		}
		
		var formattedDuration: String {
			duration.toString {
				$0.allowedUnits = [.day]
				$0.unitsStyle = .full
				$0.locale = appState.language.swiftDateLocale
			}
		}
		
		init (_ startDate: DateInRegion, _ endDate: DateInRegion, showDuration: Bool = true, @ViewBuilder content: @escaping () -> Content) {
			self.startDate = startDate
			self.endDate = endDate
			
			self.showDuration = showDuration
			
			self.content = content
		}
		
		var content: () -> Content
		
		var body: some View {
			VStack(spacing: 5) {
				datesView
				
				if showDuration {
					durationView
				}
				
				content()
			}
			.font(.footnote)
			.foregroundColor(.init(UIColor.secondaryLabel))
			.listRowBackground(listRowBackground)
		}
		
		var datesView: some View {
			HStack(alignment: .center, spacing: 10) {
				if
					appState.intervalType == .month	&&
						startDate.dateAt(.startOfDay) == startDate.dateAt(.startOfMonth).dateAt(.startOfDay) &&
						endDate.dateAt(.endOfDay) == startDate.dateAt(.endOfMonth).dateAt(.endOfDay)
				{
					Text("\(startDate.toFormat("LLLL yyyy", locale: appState.language.swiftDateLocale).uppercased())")
				} else if startDate.dateAt(.startOfDay) != endDate.dateAt(.startOfDay) {
					dateView(startDate.dateAt(.startOfDay), alignment: .trailing)
					Text("–")
					dateView(endDate.dateAt(.startOfDay), alignment: .leading)
				} else {
					dateView(startDate.dateAt(.startOfDay))
				}
			}
			.frame(maxWidth: .infinity)
		}
		
		var durationView: some View {
			HStack {
				Spacer()
				if duration > 1.days.timeInterval {
					Text("\(formattedDuration) \(Local[.withoutLectures])")
				} else {
					Text(Local[.noLectures])
				}
				Spacer()
			}
		}
		
		var listRowBackground: some View {
			Color(.systemGroupedBackground)
		}
		
		func dateView (_ date: DateInRegion, alignment: HorizontalAlignment = .center) -> some View {
			VStack(alignment: alignment) {
				switch appState.intervalType {
				case .day:
					Text("\(date.toFormat("eeee", locale: appState.language.swiftDateLocale).uppercased())")
					Text("\(date.toFormat("d MMMM yyyy", locale: appState.language.swiftDateLocale).uppercased())")
					
				case .week:
					Text("\(date.toFormat("eeee", locale: appState.language.swiftDateLocale).uppercased())")
					Text("\(date.toFormat("d MMMM yyyy", locale: appState.language.swiftDateLocale).uppercased())")
					
				case .month:
					Text("\(date.toFormat("d MMMM yyyy", locale: appState.language.swiftDateLocale).uppercased())")
				}
			}
		}
	}
}
