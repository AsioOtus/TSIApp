extension String {
	func format (_ args: CVarArg...) -> String {
		let formattedString = String.init(format: self, arguments: args)
		return formattedString
	}
	
	func capitalizedFirstLetter () -> String {
		return prefix(1).uppercased() + self.lowercased().dropFirst()
	}
	
	mutating func capitalizeFirstLetter () {
		self = self.capitalizedFirstLetter()
	}
}
