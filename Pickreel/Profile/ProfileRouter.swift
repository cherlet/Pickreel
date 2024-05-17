protocol ProfileRouterProtocol {
    func openSettings()
}

class ProfileRouter: ProfileRouterProtocol {
    weak var viewController: ProfileViewController?
    
    func openSettings() {
        guard let navigationController = viewController?.navigationController else { return }
        
        let vc = SettingsModuleBuilder.build()
        navigationController.pushViewController(vc, animated: true)
    }
}
