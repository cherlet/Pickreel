import UIKit

typealias Tabs = (
    general: UIViewController,
    profile: UIViewController
)

class TabBarController: UITabBarController {
    
    init(tabs: Tabs) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.general, tabs.profile]
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
        let generalTabBarItem = UITabBarItem()
        generalTabBarItem.image = UIImage(systemName: "infinity")
        let profileTabBarItem = UITabBarItem()
        profileTabBarItem.image = UIImage(systemName: "person")
        
        submodules.general.tabBarItem = generalTabBarItem
        submodules.profile.tabBarItem = profileTabBarItem
        
        return submodules
    }
    
}
