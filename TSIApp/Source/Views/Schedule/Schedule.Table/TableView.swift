import SwiftUI
import SwiftDate
import LoggingUtil
import SwiftUIPager
import PartialSheet

extension Schedule.Table {
	struct TableView: View {
		@EnvironmentObject var appState: App.State
		@ObservedObject var vm: ViewModel
		
		@State var isPresentingSettingsView = false
		@State var isPresentingDateView = false
		
		@ObservedObject var sheetManager: PartialSheetManager = PartialSheetManager()
		
		init (vm: ViewModel) {
			self.vm = vm
			
			UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
			UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
		}
		
		var body: some View {
			NavigationView {
				VStack(spacing: 0) {
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
					
					Pager(page: vm.page, data: vm.periodViewModels, id: \.period) { periodVM in
						Schedule.Table.PeriodView(vm: periodVM)
					}
					.draggingAnimation(.standard(duration: 0.5))
					.onPageChanged { i in
						withAnimation {	vm.pageChanged(i) }
					}
					.padding(0)
					.edgesIgnoringSafeArea(.all)
				}
				.navigationBarTitle(navigationBarTitleText, displayMode: .inline)
				.navigationBarItems(leading: scheduleSettingsButton, trailing: todayButton)
				.toolbar {
					ToolbarItem(placement: .principal) {
						title
					}
				}
				.navigationBarColor(App.colorScheme.main)
			}
			.environmentObject(sheetManager)
			.sheet(isPresented: $isPresentingDateView) {
				Schedule.Table.SelectDateView(vm: .init(appState: appState), isShown: $isPresentingDateView)
			}
			.sheet(isPresented: $isPresentingSettingsView) {
				Schedule.SettingsView(vm: .init(appState: appState), isShown: $isPresentingSettingsView)
			}
		}
		
		var todayButton: some View {
			Button(action: {
				isPresentingDateView = true
			}) {
				Image.calendar.font(.system(size: 24))
			}
		}
		
		var scheduleSettingsButton: some View {
			Button(action: {
				self.isPresentingSettingsView = true
			}) {
				Image.sliders.font(.system(size: 24))
			}
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
	}
}

extension Schedule.Table.TableView {
	struct TitleView: View {
		let groupName: String
		let roomIndex: String
		
		var body: some View	{
			HStack {
				if !groupName.isEmpty {
					Text(groupName)
				}
				
				if !roomIndex.isEmpty {
					Text(roomIndex)
						.bold()
				}
			}
		}
	}
	
	var navigationBarTitleText: String {
		var text = [String]()
		
		if !vm.appState.group.value.isEmpty {
			text.append(vm.appState.group.value)
		}
		
		if !vm.appState.room.value.isEmpty {
			text.append(vm.appState.room.value)
		}
		
		return text.joined(separator: " – ")
	}
}

struct NavigationBarModifier: ViewModifier {
	
	var backgroundColor: UIColor?
	
	init ( backgroundColor: UIColor?) {
		self.backgroundColor = backgroundColor
		let coloredAppearance = UINavigationBarAppearance()
		coloredAppearance.configureWithTransparentBackground()
		coloredAppearance.backgroundColor = .clear
		coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
		coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
		
		UINavigationBar.appearance().standardAppearance = coloredAppearance
		UINavigationBar.appearance().compactAppearance = coloredAppearance
		UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
		UINavigationBar.appearance().tintColor = .white
		
	}
	
	func body(content: Content) -> some View {
		ZStack{
			content
			VStack {
				GeometryReader { geometry in
					Color(self.backgroundColor ?? .clear)
						.frame(height: geometry.safeAreaInsets.top)
						.edgesIgnoringSafeArea(.top)
					Spacer()
				}
			}
		}
	}
}

extension View {
	
	func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
		self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
	}
	
}
