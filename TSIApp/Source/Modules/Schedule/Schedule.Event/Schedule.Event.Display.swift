import Foundation
import SwiftDate



extension Schedule.Event {
	enum ItemState<Value> {
		case value(Value)
		case notFound(String)
	}
}



extension Schedule.Event {
	struct Display {		
		let raw: Raw
			
		var groups: LoadingState<[ItemState<SelectionModel>]>
		var lecturer: LoadingState<ItemState<SelectionModel>?>
		var rooms: LoadingState<[ItemState<SelectionModel>]>
		
		mutating func fill (from scheduleFilterValuesSets: LoadingState<Schedule.FilterValuesSets>) {
			switch scheduleFilterValuesSets {
			case .notInitialized:
				groups = LoadingState.notInitialized
				lecturer = LoadingState.notInitialized
				rooms = LoadingState.notInitialized
				
			case .loading:
				groups = LoadingState.loading
				lecturer = LoadingState.loading
				rooms = LoadingState.loading
				
			case .loaded(let filterItemsSet):
				func map (_ property: KeyPath<Schedule.FilterValuesSets, [SelectionModel]>, _ key: String) -> Schedule.Event.ItemState<SelectionModel> {
					if let selectionModel = filterItemsSet[keyPath: property].item(key) {
						return .value(selectionModel)
					} else {
						return .notFound(key)
					}
				}
				
				groups = .loaded(raw.groups.map { map(\.groups, $0) })
				lecturer = .loaded(raw.lecturer.isEmpty ? nil : map(\.lecturers, raw.lecturer))
				rooms = .loaded(raw.rooms.map { map(\.rooms, $0) })
				
			case .failed(let error):
				groups = LoadingState.failed(error)
				lecturer = LoadingState.failed(error)
				rooms = LoadingState.failed(error)
			}
		}
	}
}

