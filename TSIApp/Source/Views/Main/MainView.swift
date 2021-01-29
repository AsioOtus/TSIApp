import SwiftUI



struct MainView: SwiftUI.View {
	@State var selectedTabIndex = 0
	
	var body: some SwiftUI.View {
		TabView(selection: $selectedTabIndex) {
			Schedule.Table.TableView()
				.tabItem {
					Image.dashList
					Text(Local[.schedule])
				}
				.tag(0)
				.environmentObject(App.State.current)
			
			Preferences.FormView()
				.tabItem {
					Image.gear
					Text(Local[.preferences])
				}
				.tag(1)
		}
	}
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		MainView()
    }
}
