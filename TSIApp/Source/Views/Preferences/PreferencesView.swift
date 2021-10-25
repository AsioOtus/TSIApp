import SwiftUI

extension Preferences {
	struct PreferencesView: View {
		@ObservedObject var vm: ViewModel
		
		private var selectedLanguageProxyBinding: Binding<FrontendLanguage> {
			Binding<FrontendLanguage>(
				get: { vm.appState.language },
				set: { vm.appState.language = $0 }
			)
		}
		
		var languageSelectView: some View {
			LanguageSelectView(selectedLanguage: selectedLanguageProxyBinding)
				.navigationTitle(Text(Local[.selectLanguage]))
				.navigationBarColor(App.colorScheme.main)
		}
		
		var about: some View {
			AboutView()
				.navigationTitle(Text(Local[.about]))
				.navigationBarColor(App.colorScheme.main)
		}
		
		var body: some View {
			NavigationView {
				List {
					Section {
						NavigationLink(destination: languageSelectView) {
							HStack {
								Text(Local[.language])
								Spacer()
								Text(Local[vm.appState.language.localizationKey])
									.foregroundColor(.secondary)
							}
						}
					}
					
					Section {
						NavigationLink(destination: about) {
							Text(Local[.about])
						}
					}
				}
				.navigationBarTitle(Text(Local[preferences: .title]), displayMode: .inline)
				.navigationBarColor(App.colorScheme.main)
				.listStyle(InsetGroupedListStyle())
			}
		}
	}
}

extension Preferences.PreferencesView {
	class ViewModel: ObservableObject {
		@Published var appState: App.State
		
		init (appState: App.State) {
			self.appState = appState
		}
	}
}
