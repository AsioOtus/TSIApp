import SwiftUI
import SwiftDate

fileprivate extension HorizontalAlignment {
	struct HeaderCenter: AlignmentID {
		static func defaultValue (in context: ViewDimensions) -> CGFloat {
			context[HorizontalAlignment.center]
		}
	}
	
	static let headerCenter = HorizontalAlignment(HeaderCenter.self)
}

extension Schedule.Table {
	struct EmptyDayView: View {
		let startDate: DateInRegion
		let endDate: DateInRegion
		
		@EnvironmentObject var appState: App.State
		
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
		
		var body: some View {
			Section(header: header, footer: footer) { }
		}
		
		var header: some View {
			datesView
				.frame(maxWidth: .infinity)
				.alignmentGuide(HorizontalAlignment.headerCenter) { d in
					d[HorizontalAlignment.center]
				}
		}
		
		var footer: some View {
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
		
		var datesView: some View {
			HStack {
				if
					appState.intervalType == .month	&&
						startDate.dateAt(.startOfDay) == startDate.dateAt(.startOfMonth).dateAt(.startOfDay) &&
						endDate.dateAt(.endOfDay) == startDate.dateAt(.endOfMonth).dateAt(.endOfDay)
				{
					Text("\(startDate.toFormat("LLLL yyyy", locale: appState.language.swiftDateLocale).capitalized)")
				} else if startDate.dateAt(.startOfDay) != endDate.dateAt(.startOfDay) {
					dateView(startDate.dateAt(.startOfDay))
					Text("–")
					dateView(endDate.dateAt(.startOfDay))
				} else {
					dateView(startDate.dateAt(.startOfDay))
				}
			}
		}
		
		func dateView (_ date: DateInRegion) -> some View {
			VStack {
				switch appState.intervalType {
				case .day:
					Text("\(date.toFormat("eeee", locale: appState.language.swiftDateLocale).capitalized)")
					Text("\(date.toFormat("d MMMM yyyy", locale: appState.language.swiftDateLocale).capitalized)")
					
				case .week:
					Text("\(date.toFormat("eeee", locale: appState.language.swiftDateLocale).capitalized)")
					Text("\(date.toFormat("d MMMM yyyy", locale: appState.language.swiftDateLocale).capitalized)")
					
				case .month:
					Text("\(date.toFormat("d MMMM yyyy", locale: appState.language.swiftDateLocale).capitalized)")
				}
			}
		}
	}
}

struct EmptyDayView2: View {
	@EnvironmentObject var appState: App.State
	
	let startDate: DateInRegion
	let endDate: DateInRegion
	
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
	
	var body: some View {
		VStack(spacing: 5) {
			datesView
			durationView
		}
		.font(.system(size: 12))
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
