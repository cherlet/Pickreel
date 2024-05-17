import UIKit

class TabBarModuleBuilder {
    static func build(using submodules: Tabs) -> TabBarController {
        let tabs = TabBarController.tabs(using: submodules)
        let tabBarController = TabBarController(tabs: tabs)
        tabBarController.selectedIndex = 1
        return tabBarController
    }
}
