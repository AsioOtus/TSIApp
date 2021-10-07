import SwiftUI
import SwiftDate

extension Schedule.Table.SelectDateView {
	class ViewModel: ObservableObject {
		let originalDate: DateInRegion
		
		@ObservedObject var appState: App.State
		@Published var date: Date
		
		init (appState: App.State) {
			self.originalDate = appState.dateTime
			
			self.appState = appState
			self.date = appState.dateTime.date
		}
		
		func todayButtonPressed () {
			self.date = Date()
		}
		
		func tomorrowButtonPressed () {
			self.date = (DateInRegion() + 1.days).date
		}
		
		func theDayAfterTomorrowButtonPressed () {
			self.date = (DateInRegion() + 2.days).date
		}
		
		func done () {
			let newDate = DateInRegion(date)
			
			guard newDate != originalDate else { return }
			
			appState.dateTime = DateInRegion(date)
			appState.dateTimeUpdated.send()
		}
	}
}
