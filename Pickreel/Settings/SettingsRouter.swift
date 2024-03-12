protocol SettingsRouterProtocol {
    func openLogin()
}

class SettingsRouter: SettingsRouterProtocol {
    weak var viewController: SettingsViewController?
    
    func openLogin() {
        guard let navigationController = viewController?.navigationController else { return }
        
        let vc = LoginModuleBuilder.build()
        navigationController.pushViewController(vc, animated: true)
    }
}
