import SwiftUI

struct MainView: SwiftUI.View {
	@EnvironmentObject var appState: App.State
	
	@State var selectedTabIndex = 0
	@State var isStartViewShown = LaunchCounter.default.isFirst
	
	let tableViewVM: Schedule.Table.TableView.ViewModel
	
	init (_ tableViewVM: Schedule.Table.TableView.ViewModel) {
		self.tableViewVM = tableViewVM
	}
	
	var body: some SwiftUI.View {
		if isStartViewShown {
			Main.StartView()
				.transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
				.onAppear {
					DispatchQueue.main.after(.seconds(1)) {
						withAnimation(.easeInOut(duration: 1)) {
							isStartViewShown = false
						}
					}
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
		}
	}
}
