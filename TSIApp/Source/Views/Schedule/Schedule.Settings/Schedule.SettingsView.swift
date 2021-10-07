import SwiftUI
import SwiftUIRefresh


extension Schedule {
	struct SettingsView: View {
		@EnvironmentObject var appState: App.State
		@ObservedObject private var vm: ViewModel
		
		@Binding var isShown: Bool
		
		init (vm: ViewModel, isShown: Binding<Bool>) {
			self.vm = vm
			self._isShown = isShown
		}
		
		var body: some View {
			NavigationView {
				Form {
					Section(header: Text(Local[.filters].uppercased())) {
						if vm.filterValuesSetsLoadingError != nil {
							ErrorView(message: Local[.filterValuesSetsLoadingError])
						}
						
						SelectorView(
							items: vm.groups,
							selectedItem: $vm.selectedGroup,
							filterText: $vm.groupFilterText,
							labelText: Local[.group],
							itemIsNotExistLabelText: Local[.selectedGroupIsNotExist]
						)
						
						SelectorView(
							items: vm.lecturers,
							selectedItem: $vm.selectedLecturer,
							filterText: $vm.lecturerFilterText,
							labelText: Local[.lecturer],
							itemIsNotExistLabelText: Local[.selectedLecturerIsNotExist]
						)
						
						SelectorView(
							items: vm.rooms,
							selectedItem: $vm.selectedRoom,
							filterText: $vm.roomFilterText,
							labelText: Local[.room],
							itemIsNotExistLabelText: Local[.selectedRoomIsNotExist]
						)
						
						HStack {
							Spacer()
							Button(action: { self.vm.reset() }, label: { Text(Local[.reset]) })
								.foregroundColor(.red)
							Spacer()
						}
					}
				}
				.navigationBarTitle(Text(Local[settings: .title]), displayMode: .inline)
				.navigationBarItems(
					leading: Button(action: {
						self.isShown = false
					}) { Text(Local[.cancel]) },
					trailing: Button(action: {
						self.vm.done()
						self.isShown = false
					}) { Text(Local[.done])	}
				)
				.navigationBarColor(App.colorScheme.main)
				.pullToRefresh(isShowing: self.$vm.isLoadingIndicatorVisible) {
					self.vm.refreshValues()
				}
			}
		}
	}
}



fileprivate struct SelectorView: View {
	private let labelText: String
	private let itemIsNotExistLabelText: String
	
	private var items: [SelectionModel]?
	
	private var displayedItems: [SelectionModel] {
		guard let items = items else { return [] }
		return !filterText.isEmpty ? [.empty] + items.filter { $0.value.lowercased().contains(filterText.lowercased()) } : ([.empty] + items)
	}
	
	private var isItemNotExist: Bool {
		selectedItem != .empty ? !(items?.contains(selectedItem) ?? true) : false
	}
	
	@State private var isPickerVisible = false
	
	@Binding var selectedItem: SelectionModel
	@Binding var filterText: String
	
	init (
		items: [SelectionModel]?,
		selectedItem: Binding<SelectionModel>,
		filterText: Binding<String>,
		labelText: String,
		itemIsNotExistLabelText: String
	) {
		self.items = items
		self._selectedItem = selectedItem
		self._filterText = filterText
		
		self.labelText = labelText
		self.itemIsNotExistLabelText = itemIsNotExistLabelText
	}
	
	var body: some View {
		Group {
			HStack {
				Text(labelText)
				Spacer()
				Text(self.selectedItem.value)
					.foregroundColor(.gray)
			}
			.contentShape(Rectangle())
			.onTapGesture {	self.isPickerVisible.toggle() }
			
			if isItemNotExist {
				ErrorView(message: itemIsNotExistLabelText)
			}
						
			if isPickerVisible {
				VStack {
					HStack {
						TextField(
							Local[.enterFilter],
							text: $filterText
						)
						.multilineTextAlignment(.center)
						.font(.system(size: 20))
						.padding(.top)
					}
					
					Picker(selection: $selectedItem, label: EmptyView()) {
						ForEach(displayedItems, id: \.self) {
							Text($0.value)
						}
					}
					.id(UUID())
					.pickerStyle(WheelPickerStyle())
					.labelsHidden()
				}
			}
		}
	}
}



fileprivate struct ErrorView: View {
	var message: String
	
	var body: some View {
		HStack {
			Spacer()
			Text(message)
				.foregroundColor(.white)
			Spacer()
		}
		.listRowBackground(App.colorScheme.errorMessageBackground.color)
		.frame(height: 15)
	}
}

