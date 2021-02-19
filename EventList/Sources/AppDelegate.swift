import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {

		let eventsAPIService = EventsAPIService()
		let eventsVM = EventsViewModel(eventsAPIService: eventsAPIService)
		let eventsVC = EventsViewController(viewModel: eventsVM)
		let navigationVC = UINavigationController(rootViewController: eventsVC)

		navigationVC.navigationBar.prefersLargeTitles = true

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = navigationVC
		window?.makeKeyAndVisible()

		return true
	}
}

