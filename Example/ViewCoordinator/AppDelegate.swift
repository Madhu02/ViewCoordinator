import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		/*
		    modify the mode here so you could get different behavior
		    -> stack or .single 
		*/
		window?.rootViewController = ViewController(withMode: .stack)
		window?.makeKeyAndVisible()
		return true
	}
}

