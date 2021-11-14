import SwiftUI

struct WrappingHStackView<Item: View>: UIViewControllerRepresentable {
	let items: [Item]
	let lineHeight: Double
	@Binding var height: Double
	
	func makeUIViewController (context: Context) -> UIViewController {
		WrappingHStackViewController(items.map{ UIHostingController(rootView: $0) }, lineHeight: lineHeight)
		
//		return .init(h: $height)
	}
	
	func updateUIViewController (_ collectionVC: UIViewController, context: Context) { }
}


class RandomVC: UIViewController {
	@Binding var height: Double
	
	init (h: Binding<Double>) {
		_height = h
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad () {
		super.viewDidLoad()
		
		view.backgroundColor = .red
		
		view.frame = .init(x: 0, y: 0, width: 100, height: 100)
		height = 100
		
		view.addSubview({
			let l = UILabel()
			l.text = "Lol kek"
			l.frame = .init(x: 0, y: 0, width: 100, height: 100)
			return l
		}())
	}
}
