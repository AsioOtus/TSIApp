import UIKit

protocol AppColorScheme {
	var main: UIColor { get }
	var errorMessageBackground: UIColor { get }
	var secondaryButtonForeground: UIColor { get }
	var emptyEventBackground: UIColor { get }
}
