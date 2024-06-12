import SwiftUI

extension Schedule.Table {
	struct SelectDateView: View {
		@ObservedObject private var vm: ViewModel
		
		@Binding var isShown: Bool
		
		init (vm: ViewModel, isShown: Binding<Bool>) {
			self.vm = vm
			self._isShown = isShown
		}
		
		var body: some View {
			NavigationView {
				VStack (spacing: 0) {
					HStack {
						Button(Local[.today]) { vm.todayButtonPressed() }
						Spacer()
						Button(Local[.tomorrow]) { vm.tomorrowButtonPressed() }
						Spacer()
						Button(Local[.theDayAfterTomorrow]) { vm.theDayAfterTomorrowButtonPressed() }
					}
					.foregroundColor(vm.appState.colorScheme.secondaryButtonForeground.color)
					.padding(.top, 12)
					.padding(.bottom, 12)
					.padding([.leading, .trailing], 16)
					
					DatePicker(
						Local[.datePickerLabel],
						selection: $vm.date,
						in: Schedule.lastEarlyDate.date...,
						displayedComponents: .date
					)
					.datePickerStyle(GraphicalDatePickerStyle())
					.padding([.leading, .trailing], 16)
					
					Spacer()
				}
				.onAppear {
					App.Delegate.amplitude.track(eventType: "calendar.presented")
				}
				.navigationBarTitle(Local[selectDate: .title], displayMode: .inline)
				.navigationBarItems(
					leading:
						Button(Local[.cancel]) {
							isShown = false
						}
						.foregroundColor(.white),
					trailing:
						Button(Local[.done]) {
							vm.done()
							isShown = false
						}
						.foregroundColor(.white)
				)
				.navigationBarColor(App.colorScheme.main)
			}
		}
	}
}
