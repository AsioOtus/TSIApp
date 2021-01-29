import SwiftUI



extension Preferences {
	struct FormView: View {		
		private var selectedLanguageProxyBinding: Binding<FrontendLanguage> {
			Binding<FrontendLanguage>(
				get: { App.State.current.language },
				set: { App.State.current.language = $0 }
			)
		}
		
		var body: some View {
			NavigationView {
				Form {
					Section {
						Picker (selection: selectedLanguageProxyBinding, label: Text(Local[.language])) {
							ForEach(FrontendLanguage.allCases, id: \.self) {
								Text(Local[$0.localizationKey])
							}
						}
					}
				}
				.navigationBarTitle(Text(Local[.preferences]), displayMode: .inline)
//				.navigationBarColor(App.colorScheme.main)
			}
		}
	}
}



struct PreferencesView_Previews: PreviewProvider {
	static var previews: some View {
		Preferences.FormView()
	}
}
