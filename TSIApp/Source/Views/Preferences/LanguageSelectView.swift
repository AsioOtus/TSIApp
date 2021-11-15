import SwiftUI

extension Preferences {
	struct LanguageSelectView: View {
		@Environment(\.presentationMode) var presentation
		@EnvironmentObject var appState: App.State
		
		@Binding var selectedLanguage: FrontendLanguage
		
		func nameView (_ language: AppLanguage) -> some View {
			VStack(alignment: .leading) {
				if
					let currentLanguageCode = selectedLanguage.code,
					let languageNameLocalization = Locale(identifier: currentLanguageCode).localizedString(forLanguageCode: language.code)
				{
					Text(languageNameLocalization.capitalized)
				} else {
					Text(Local[language.localizationKey])
				}
				
				Text(language.nativeName + " " + language.flagEmoji)
					.font(.footnote)
			}
		}
		
		var body: some View {
			List {
				Section {
					HStack {
						VStack(alignment: .leading) {
							Text(Local[FrontendLanguage.system.localizationKey])
							if
								let currentLanguageCode = FrontendLanguage.system.code,
								let languageNameLocalization = Locale(identifier: currentLanguageCode).localizedString(forLanguageCode: currentLanguageCode)
							{
								Text(languageNameLocalization.capitalized + (FrontendLanguage.system.appLanguageOrSystem.map{ " " + $0.flagEmoji } ?? ""))
									.font(.footnote)
							}
						}
						
						Spacer()
						
						if FrontendLanguage.system == selectedLanguage {
							Image(systemName: "checkmark")
								.foregroundColor(.blue)
						}
					}
					.contentShape(Rectangle())
					.onTapGesture {
						presentation.wrappedValue.dismiss()
						selectedLanguage = FrontendLanguage.system
					}
				}
				
				Section {
					ForEach(AppLanguage.availableLanguages, id: \.self) { language in
						HStack {
							nameView(language)
							
							Spacer()
							
							if language == selectedLanguage.appLanguage {
								Image(systemName: "checkmark")
									.foregroundColor(.blue)
							}
						}
						.contentShape(Rectangle())
						.onTapGesture {
							presentation.wrappedValue.dismiss()
							selectedLanguage = .app(language)
						}
					}
					
					HStack {
						nameView(AppLanguage.latvian)
							.foregroundColor(UIColor.secondaryLabel.color)
						
						Spacer()
						
						Text(Local[.inDevelopment])
							.font(.callout)
							.foregroundColor(UIColor.tertiaryLabel.color)
					}
					.listRowBackground(appState.colorScheme.emptyEventBackground.color)
					.contentShape(Rectangle())
				}
			}
			.listStyle(InsetGroupedListStyle())
		}
	}
}
