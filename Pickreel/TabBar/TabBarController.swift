import UIKit

typealias Tabs = (
    search: UIViewController,
    general: UIViewController,
    profile: UIViewController,
    login: UIViewController // delete in future
)

class TabBarController: UITabBarController {
    
    init(tabs: Tabs) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.search, tabs.general, tabs.profile, tabs.login]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

extension TabBarController {
    func initialize() {
        tabBar.tintColor = ThemeColor.generalColor
        tabBar.unselectedItemTintColor = ThemeColor.silentColor
    }
    
    static func tabs(using submodules: Tabs) -> Tabs {
        let searchTabBarItem = UITabBarItem()
        searchTabBarItem.image = UIImage(systemName: "magnifyingglass")
        let generalTabBarItem = UITabBarItem()
        generalTabBarItem.image = UIImage(systemName: "infinity")
        let profileTabBarItem = UITabBarItem()
        profileTabBarItem.image = UIImage(systemName: "person")
        let loginTabBarItem = UITabBarItem()
        loginTabBarItem.image = UIImage(systemName: "square.fill")
        
        submodules.search.tabBarItem = searchTabBarItem
        submodules.general.tabBarItem = generalTabBarItem
        submodules.profile.tabBarItem = profileTabBarItem
        submodules.login.tabBarItem = loginTabBarItem// delete in future
        
        return submodules
    }
    
}
