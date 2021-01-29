import UIKit
import SwiftUI



struct PageView: View {
	var periods: [Schedule.Table.Period]
	@Binding var currentPeriod: Schedule.Table.Period
	
	init (_ periods: [Schedule.Table.Period], _ currentPeriod: Binding<Schedule.Table.Period>) {
		self.periods = periods
		self._currentPeriod = currentPeriod
	}
	
	var body: some View {
		PageViewController(periods: periods, currentPeriod: $currentPeriod)
	}
}



final class PageViewController: UIViewControllerRepresentable {
	var controllers: [UIHostingController<PeriodView>]
	var currentPeriod: Schedule.Table.Period
	var previousPeriod: Schedule.Table.Period
	
	init (periods: [Schedule.Table.Period], currentPeriod: Binding<Schedule.Table.Period>) {
		self.controllers = periods.map { UIHostingController(rootView: PeriodView(period: $0)) }
		self.currentPeriod = currentPeriod.wrappedValue
		self.previousPeriod = currentPeriod.wrappedValue
	}
	
	func makeCoordinator () -> Coordinator {
		Coordinator(self)
	}
	
	func makeUIViewController (context: Context) -> UIPageViewController {
		let pageViewController = UIPageViewController(
			transitionStyle: .scroll,
			navigationOrientation: .horizontal
		)
		
		pageViewController.dataSource = context.coordinator
		pageViewController.delegate = context.coordinator
		
		return pageViewController
	}
	
	func updateUIViewController (_ pageViewController: UIPageViewController, context: Context) {
		guard !controllers.isEmpty else { return }
		
		guard
			let currentPeriodIndex = controllers.firstIndex(where: { $0.rootView.period.originDate == currentPeriod.originDate }),
			let previousPeriodIndex = controllers.firstIndex(where: { $0.rootView.period.originDate == previousPeriod.originDate })
		else { return }
		
		let direction: UIPageViewController.NavigationDirection = previousPeriodIndex < currentPeriodIndex ? .forward : .reverse
		context.coordinator.parent = self
		
		pageViewController.setViewControllers([controllers[currentPeriodIndex]], direction: .forward, animated: true) { _ in
			DispatchQueue.main.async {
				self.previousPeriod = self.currentPeriod
			}
		}
	}
		
	
	
	class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
		var parent: PageViewController
		
		init (_ pageViewController: PageViewController) {
			self.parent = pageViewController
		}
		
		func pageViewController (_ pageViewController: UIPageViewController, viewControllerBefore vc: UIViewController) -> UIViewController? {
			guard let hostingVC = vc as? UIHostingController<PeriodView> else { return nil }
			
			guard
				let index = parent.controllers.firstIndex(where: { $0.rootView.period.originDate == hostingVC.rootView.period.originDate }),
				index != 0
			else { return nil }
			
			return parent.controllers[index - 1]
		}
		
		func pageViewController (_ pageViewController: UIPageViewController, viewControllerAfter vc: UIViewController) -> UIViewController? {
			guard let hostingVC = vc as? UIHostingController<PeriodView> else { return nil }
			
			guard
				let index = parent.controllers.firstIndex(where: { $0.rootView.period.originDate == hostingVC.rootView.period.originDate }),
				index + 1 != parent.controllers.count
			else { return nil }
			
			return parent.controllers[index + 1]
		}
		
		func pageViewController (_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
			guard
				completed,
				let vc = pageViewController.viewControllers?.first,
				let hostingVC = vc as? UIHostingController<PeriodView>,
				let currentPeriod = parent.controllers.first(where: { $0.rootView.period.originDate == hostingVC.rootView.period.originDate })
			else { return }
			
			parent.currentPeriod = currentPeriod.rootView.period
		}
	}
}

