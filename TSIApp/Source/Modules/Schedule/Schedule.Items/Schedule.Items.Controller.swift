extension Schedule.Items {
	struct Controller {
		private init () { }
		static let current = Self()
		
		private(set) var events = LoadingState<Schedule.FilterValuesSets>.notInitialized
	}
}

extension Array where Element == SelectionModel {
	func item (_ itemKey: String) -> SelectionModel? {
		let item = first{ $0.key == itemKey }
		return item
	}
	
	func items (_ itemKeys: [String]) -> [SelectionModel]? {
		let items = filter{ itemKeys.contains($0.key) }
		let resultItems = itemKeys.count == items.count ? items : nil
		return resultItems
	}
}
