import AmplitudeSwift
import UIKit
import LoggingUtil
import UserDefaultsUtil

extension App {
	@UIApplicationMain
	class Delegate: UIResponder, UIApplicationDelegate {
		private(set) static var current: Delegate!
		private(set) static var amplitude: Amplitude!

		func application (_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
			Self.amplitude = .init(configuration: .init(apiKey: "f058128cbd598bb1b17be6524fb018dc"))
			Self.amplitude.track(eventType: "app.start")

			LaunchCounter.default.launch(cycle: Date().toFormat("hh:mm:ss"))

			Logging.defaultLogger.notice("APPLICATION STARTED | Launch number: \(LaunchCounter.default.count) – \(LaunchCounter.default.label)")
			
			Self.saveAppDelegateInstanceLink(application)
			
			App.Controller.current.handleApplicationStart()
			
			return true
		}
		
		func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
			return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
		}
		
		func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
	}
}

extension App.Delegate {
	private static func saveAppDelegateInstanceLink (_ application: UIApplication) {
		guard let appDelegate = application.delegate as? App.Delegate else { fatalError("Cannot cast application delegate to type App.Delegate") }
		current = appDelegate
	}
}
