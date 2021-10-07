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
					.padding(.top, 12)
					.padding(.bottom, 12)
					.padding([.leading, .trailing], 16)
					
					Divider()
					
					DatePicker(
						Local[.datePickerLabel],
						selection: $vm.date,
						in: Schedule.lastEarlyDate.date...,
						displayedComponents: .date
					)
					.datePickerStyle(GraphicalDatePickerStyle())
					.padding(.top, 12)
					.padding([.leading, .trailing], 16)
					
					Spacer()
				}
				.navigationBarTitle(Local[selectDate: .title], displayMode: .inline)
				.navigationBarItems(
					leading: Button(Local[.cancel]) {
						isShown = false
					},
					trailing: Button(Local[.done]) {
						vm.done()
						isShown = false
					}
				)
				.navigationBarColor(App.colorScheme.main)
			}
		}
	}
}
