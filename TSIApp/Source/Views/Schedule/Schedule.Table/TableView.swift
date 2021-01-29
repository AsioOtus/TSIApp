import SwiftUI
import SwiftDate
import Log
import SwiftUIPager



extension Schedule.Table {
	struct TableView: View {
		@EnvironmentObject private var appState: App.State
		@StateObject private var vm = ViewModel()
		
		init () {
			UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
			UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
		}
		
		var body: some View {
			NavigationView {
				VStack {
					Picker (selection: $appState.intervalType, label: Text("")) {
						ForEach(Schedule.IntervalType.allCases, id: \.self) { intervalType in
							Text(Local[intervalType.localizationKey]).foregroundColor(.white)
						}
					}
					.pickerStyle(SegmentedPickerStyle())
					.labelsHidden()
					.padding()
					.background(App.colorScheme.main.color)
					
					Pager(page: $vm.currentPeriodIndex, data: vm.currentPeriods,  id: \.self) { period in
//						Text("\(item)")
//							.frame(minWidth: 0,
//								   maxWidth: .infinity,
//								   minHeight: 0,
//								   maxHeight: .infinity,
//								   alignment: .topLeading
//							)
//							.background(Color(hue: .random(in: 0...0.99), saturation: .random(in: 0...0.99), brightness: 0.5))
					}
//					.onDraggingEnded(vm.updateItems)
					
//					TabView {
//						ForEach(vm.currentPeriods, id: \.originDate) { period in
//							PeriodView(period: period)
//								.onAppear {
//									Log.default.default(period.originDate.toFormat("dd.MM.yyyy"))
//								}
//						}
//					}
//					.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//					.id(UUID())
				}
				.navigationBarTitle(Text("Lecturer name"), displayMode: .inline)
				.navigationBarItems(leading: EmptyView(), trailing: ScheduleSettingsButtonView())
				.navigationBarColor(App.colorScheme.main)
			}
			.background(App.colorScheme.main.color)
		}
	}
}



fileprivate struct ScheduleSettingsButtonView: View {
	@State private var isPresentingSettingsView = false
	
	init () { }
	
	var body: some View {
		Button(action: {
			self.isPresentingSettingsView = true
		}) {
			Image.sliders.font(.system(size: 24))
		}.sheet(isPresented: $isPresentingSettingsView) {
			Schedule.SettingsView(isShown: $isPresentingSettingsView)
		}
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
