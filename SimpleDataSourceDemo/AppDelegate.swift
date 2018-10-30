import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window?.rootViewController = UINavigationController(rootViewController: MovieViewController(style: .grouped))
        window?.makeKeyAndVisible()

        return true
    }
}
