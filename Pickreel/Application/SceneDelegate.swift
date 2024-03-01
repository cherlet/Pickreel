import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let generalViewController = GeneralModuleBuilder.build()
        let profileViewController = ProfileModuleBuilder.build()
        let searchViewController = SearchModuleBuilder.build()
        let loginViewController = LoginModuleBuilder.build() // delete in future
        let modules = (
            search: searchViewController,
            general: generalViewController,
            profile: profileViewController,
            login: loginViewController // delete in future
        )
        let tabBarController = TabBarModuleBuilder.build(using: modules)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
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

