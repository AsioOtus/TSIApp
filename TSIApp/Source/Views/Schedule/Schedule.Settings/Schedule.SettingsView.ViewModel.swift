import SwiftUI
import UserDefaultsUtil



extension Schedule.SettingsView {
	class ViewModel: ObservableObject {
		var filterValuesSetsLoadingError: Error? {
			let resultError: Error?
			
			if case .failed(let error) = App.State.current.scheduleFilterValuesSets {
				resultError = error
			} else {
				resultError = nil
			}
			
			return resultError
		}
		
		var isFilterValuesSetsLoading: Bool {
			let result: Bool
			
			if case .loading = App.State.current.scheduleFilterValuesSets {
				result = true
			} else {
				result = false
			}
			
			isLoadingIndicatorVisible = result
			
			return result
		}
		
		var groups: [SelectionModel]? {
			let result: [SelectionModel]?
			
			if case .loaded(let filterValuesSets) = App.State.current.scheduleFilterValuesSets {
				result = filterValuesSets.groups
			} else {
				result = nil
			}
			
			return result
		}
		var lecturers: [SelectionModel]? {
			let result: [SelectionModel]?
			
			if case .loaded(let filterValuesSets) = App.State.current.scheduleFilterValuesSets {
				result = filterValuesSets.lecturers
			} else {
				result = nil
			}
			
			return result
		}
		var rooms: [SelectionModel]? {
			let result: [SelectionModel]?
			
			if case .loaded(let filterValuesSets) = App.State.current.scheduleFilterValuesSets {
				result = filterValuesSets.rooms
			} else {
				result = nil
			}
			
			return result
		}
		
		@Published var isLoadingIndicatorVisible: Bool = false
		
		@Published var selectedGroup = SelectionModel.empty
		@Published var selectedLecturer = SelectionModel.empty
		@Published var selectedRoom = SelectionModel.empty
		
		@Published var groupFilterText = ""
		@Published var lecturerFilterText = ""
		@Published var roomFilterText = ""
		
		init () {
			selectedGroup = App.State.current.group
			selectedLecturer = App.State.current.lecturer
			selectedRoom = App.State.current.room
			
			groupFilterText = UserDefaults.groupsFilter.loadOrDefault()
			lecturerFilterText = UserDefaults.lecturersFilter.loadOrDefault()
			roomFilterText = UserDefaults.roomFilter.loadOrDefault()
		}
		
		func reset () {
			selectedGroup = .empty
			selectedLecturer = .empty
			selectedRoom = .empty
			
			groupFilterText = ""
			lecturerFilterText = ""
			roomFilterText = ""
		}
		
		func refreshValues () {
			App.Controller.current.loadScheduleFilterValuesSets()
		}
		
		func done () {
			App.State.current.group = selectedGroup
			App.State.current.lecturer = selectedLecturer
			App.State.current.room = selectedRoom
			
			UserDefaults.groupsFilter.save(groupFilterText)
			UserDefaults.lecturersFilter.save(lecturerFilterText)
			UserDefaults.roomFilter.save(roomFilterText)
		}
	}
}
