import UIKit

class WrappingHStackViewController: UIViewController {
	private var items = [UIViewController]()
	
	private let lineHeight: Double
	private let spacingX: Double
	private let spacingY: Double
	
	init (_ items: [UIViewController], lineHeight: Double, spacingX: Double = 4, spacingY: Double = 4) {
		self.lineHeight = lineHeight
		self.spacingX = spacingX
		self.spacingY = spacingY
		
		self.items = items
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init? (coder: NSCoder) {
		fatalError()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		_ = view.safeAreaLayoutGuide // Magic call, do not remove
		
		integrateItems()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		displayItems()
	}
}

extension WrappingHStackViewController {
	func integrateItems () {
		items.forEach { vc in
			guard let newView = vc.view else { return }
			
			addChild(vc)
			view.addSubview(newView)
			vc.didMove(toParent: self)
			
			newView.translatesAutoresizingMaskIntoConstraints = false
			newView.backgroundColor = .clear
		}
	}
	
	func displayItems () {
		let viewWidth = view.frame.size.width
		
		var currentOriginX: CGFloat = 0
		var currentOriginY: CGFloat = 0
		
		items.forEach { vc in
			guard let vcView = vc.view else { return }
			
			if currentOriginX + vcView.frame.width > viewWidth {
				currentOriginX = 0
				currentOriginY += lineHeight + spacingY
			}
			
			vcView.frame.origin.x = currentOriginX
			vcView.frame.origin.y = currentOriginY
			
			currentOriginX += vcView.frame.width + spacingX
		}
	}
}




class WrappingHStackUIView: UIView {
	private var views = [UIView]()
	
	private let lineHeight: Double
	private let spacingX: Double
	private let spacingY: Double
	
	init (_ views: [UIView], lineHeight: Double, spacingX: Double = 4, spacingY: Double = 4) {
		self.lineHeight = lineHeight
		self.spacingX = spacingX
		self.spacingY = spacingY
		
		self.views = views
		
		super.init(frame: .init(x: 0, y: 0, width: 0, height: 0))
		
		integrateView()
		
		setContentHuggingPriority(.required, for: .vertical)
		setContentHuggingPriority(.required, for: .horizontal) // << here !!
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	required init? (coder: NSCoder) {
		fatalError()
	}
	
	override func updateConstraints () {
		super.updateConstraints()
		
		displayViews()
	}
}

extension WrappingHStackUIView {
	func integrateView () {
		views.forEach { view in
			addSubview(view)
			view.translatesAutoresizingMaskIntoConstraints = false
			view.backgroundColor = .clear
		}
	}
	
	func displayViews () {
		let width = frame.size.width
		
		var currentOriginX: CGFloat = 0
		var currentOriginY: CGFloat = 0
		
		views.forEach { view in
			if currentOriginX + view.frame.width > width {
				currentOriginX = 0
				currentOriginY += lineHeight + spacingY
			}
			
			view.frame.origin.x = currentOriginX
			view.frame.origin.y = currentOriginY
			
			currentOriginX += view.frame.width + spacingX
		}
	}
}
