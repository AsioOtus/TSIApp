import SwiftUI
import SwiftDate
import LoggingUtil
import SwiftUIPager

extension Schedule.Table {
	struct TableView: View {
		@EnvironmentObject var appState: App.State
		@ObservedObject var vm: ViewModel
		
		@State var isPresentingSettingsView = false
		@State var isPresentingDateView = false
		
		init (vm: ViewModel) {
			self.vm = vm
			
			UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
			UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
		}
		
		var body: some View {
			NavigationView {
				VStack(spacing: 0) {
					intervalTypePicker
					
					if vm.appState.group == .empty && vm.appState.lecturer == .empty && vm.appState.room == .empty {
						unselectedFilterMessage
					} else {
						pagerView
					}
				}
				.navigationBarTitleDisplayMode(.inline)
				.navigationBarItems(leading: scheduleSettingsButton, trailing: todayButton)
				.toolbar {
					ToolbarItem(placement: .principal) {
						title
					}
				}
				.navigationBarColor(App.colorScheme.main)
			}
			.sheet(isPresented: $isPresentingDateView) {
				Schedule.Table.SelectDateView(vm: .init(appState: appState), isShown: $isPresentingDateView)
			}
			.sheet(isPresented: $isPresentingSettingsView) {
				Schedule.SettingsView(vm: .init(appState: appState), isShown: $isPresentingSettingsView)
			}
		}
	}
}

extension Schedule.Table.TableView {
	var intervalTypePicker: some View {
		Picker (selection: $vm.appState.intervalType, label: Text("")) {
			ForEach(Schedule.IntervalType.allCases, id: \.self) { intervalType in
				Text(Local[intervalType.localizationKey])
					.foregroundColor(.white)
			}
		}
		.pickerStyle(SegmentedPickerStyle())
		.labelsHidden()
		.padding()
		.background(App.colorScheme.main.color.edgesIgnoringSafeArea([.leading, .trailing]))
	}
	
	var todayButton: some View {
		Button(action: {
			isPresentingDateView = true
		}) {
			Image.calendar.font(.system(size: 20))
		}
		.foregroundColor(.white)
	}
	
	var scheduleSettingsButton: some View {
		Button(action: {
			self.isPresentingSettingsView = true
		}) {
			Image.sliders.font(.system(size: 20))
		}
		.foregroundColor(.white)
	}
	
	var title: some View {
		VStack {
			HStack {
				if !vm.appState.group.value.isEmpty {
					Text(vm.appState.group.value)
						.font(.headline.weight(.bold))
				}
				
				if !vm.appState.group.value.isEmpty && !vm.appState.room.value.isEmpty {
					Text("|")
						.foregroundColor(.gray)
				}
				
				if !vm.appState.room.value.isEmpty {
					Text(vm.appState.room.value)
						.font(.headline.weight(.bold))
				}
			}
			
			if vm.appState.lecturer != .empty {
				Text(vm.appState.lecturer.value)
			}
		}
		.foregroundColor(.white)
	}
	
	var pagerView: some View {
		Pager(page: vm.page, data: vm.periodViewModels, id: \.period) { periodVM in
			Schedule.Table.PeriodView(vm: periodVM)
		}
		.draggingAnimation(.interactive)
		.onPageChanged { i in
			withAnimation {	vm.pageChanged(i) }
		}
		.padding(0)
		.ignoresSafeArea()
	}
	
	var unselectedFilterMessage: some View {
		VStack(alignment: .center) {
			Text(Local[.noFilterSelected])
				.padding()
			Text("\(Local[.filterSetInstructionStart]) \"\(Image(systemName: "slider.horizontal.3"))\" \(Local[.filterSetInstructionEnd])")
				.font(.footnote)
				.padding()
				.multilineTextAlignment(.center)
		}
		.frame(maxHeight: .infinity)
	}
}
