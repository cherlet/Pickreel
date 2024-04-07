import UIKit

typealias Tabs = (
    search: UIViewController,
    general: UIViewController,
    profile: UIViewController
)

class TabBarController: UITabBarController {
    
    init(tabs: Tabs) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.search, tabs.general, tabs.profile]
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
        tabBar.tintColor = ThemeColor.general
        tabBar.unselectedItemTintColor = ThemeColor.silent
    }
    
    static func tabs(using submodules: Tabs) -> Tabs {
        let searchTabBarItem = UITabBarItem()
        searchTabBarItem.image = UIImage(systemName: "magnifyingglass")
        let generalTabBarItem = UITabBarItem()
        generalTabBarItem.image = UIImage(systemName: "infinity")
        let profileTabBarItem = UITabBarItem()
        profileTabBarItem.image = UIImage(systemName: "person")
        
        submodules.search.tabBarItem = searchTabBarItem
        submodules.general.tabBarItem = generalTabBarItem
        submodules.profile.tabBarItem = profileTabBarItem
        
        return submodules
    }
    
}
