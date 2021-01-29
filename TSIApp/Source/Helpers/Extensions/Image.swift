import SwiftUI



extension Image {
	struct SystemNames {
		static let mappin = "mappin"
		static let mappinEllipse = "mappin.and.ellipse"
		
		static let map = "map"
		static let mapFill = "map.fill"
	}
}



extension Image {
	static let calendar = Image(systemName: "calendar")
	static let table = Image(systemName: "table")
	static let dashList = Image(systemName: "list.dash")
	static let sliders = Image(systemName: "slider.horizontal.3")
	static let gear = Image(systemName: "gear")
	static let house = Image(systemName: "house.fill")
	
	static let mappin = Image(systemName: SystemNames.mappin)
	static let mappinEllipse = Image(systemName: "mappin.and.ellipse")
	
	static let map = Image(systemName: SystemNames.map)
	static let mapFill = Image(systemName: SystemNames.mapFill)
}
