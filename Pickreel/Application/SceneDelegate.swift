import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let generalViewController = GeneralModuleBuilder.build()
        let profileViewController = ProfileModuleBuilder.build()
        let searchViewController = SearchModuleBuilder.build()
        let modules = (
            search: searchViewController,
            general: generalViewController,
            profile: profileViewController
        )
        
        let tabBarController = TabBarModuleBuilder.build(using: modules)
        
        let navigationController = UINavigationController(rootViewController: tabBarController)
        navigationController.isNavigationBarHidden = true
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        if NetworkManager.shared.userSession == nil {
            print("SESSION IS NIL")
            let loginViewController = LoginModuleBuilder.build()
            navigationController.pushViewController(loginViewController, animated: false)
        }
    }



    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

