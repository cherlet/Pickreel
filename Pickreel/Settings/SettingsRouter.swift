import Foundation

protocol SettingsRouterProtocol {
    func openLogin()
}

class SettingsRouter: SettingsRouterProtocol {
    weak var viewController: SettingsViewController?
    
    func openLogin() {
        DispatchQueue.main.async {
            guard let navigationController = self.viewController?.navigationController else { return }
            
            let vc = LoginModuleBuilder.build()
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
