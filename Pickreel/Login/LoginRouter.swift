protocol LoginRouterProtocol {
    func openRegister()
    func openApp()
}

class LoginRouter: LoginRouterProtocol {
    weak var viewController: LoginViewController?
    
    func openRegister() {
        let vc = RegisterModuleBuilder.build()
        vc.modalPresentationStyle = .overFullScreen
        vc.onHide = { [weak self] email, password in
            if let email = email, let password = password {
                self?.viewController?.presenter?.didTapSignInButton(email, password)
            }
        }
        viewController?.present(vc, animated: false) {
            vc.show()
        }
    }
    
    func openApp() {
        if let navigationController = viewController?.navigationController {
            navigationController.popToRootViewController(animated: true)
        } else {
            viewController?.dismiss(animated: true, completion: nil)
        }
    }

}
