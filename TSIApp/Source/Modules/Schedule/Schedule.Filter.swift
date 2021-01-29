import Foundation

extension Schedule {
	struct Filter {
		let from: Int
		let to: Int
		let group: SelectionModel
		let lecturer: SelectionModel
		let room: SelectionModel
		let language: FrontendLanguage
	}
}
