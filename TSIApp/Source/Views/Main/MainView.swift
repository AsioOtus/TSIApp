import SwiftUI

struct MainView: SwiftUI.View {
	@EnvironmentObject var appState: App.State
	
	@State var selectedTabIndex = 0
	@State var isStartViewShown = true
	
	let tableViewVM: Schedule.Table.TableView.ViewModel
	
	init (_ tableViewVM: Schedule.Table.TableView.ViewModel) {
		self.tableViewVM = tableViewVM
		
		isStartViewShown = LaunchCounter.default.isFirst
	}
	
	var body: some SwiftUI.View {
		if isStartViewShown {
			Main.StartView()
				.transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
				.animation(
					.easeInOut(duration: 0.75)
					.delay(1)
				)
				.onAppear {
					isStartViewShown = false
				}
		} else {
			TabView(selection: $selectedTabIndex) {
				Schedule.Table.TableView(vm: tableViewVM)
					.tabItem {
						Image.dashList
						Text(Local[.schedule])
					}
					.tag(0)
				
				Preferences.PreferencesView(vm: .init(appState: appState))
					.tabItem {
						Image.gear
						Text(Local[.preferences])
					}
					.tag(1)
			}
			.transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
			.animation(
				.easeInOut(duration: 0.75)
					.delay(1)
			)
		}
	}
}
