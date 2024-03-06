protocol LoginRouterProtocol {
    func openRegister()
}

class LoginRouter: LoginRouterProtocol {
    weak var viewController: LoginViewController?
    
    func openRegister() {
        let vc = RegisterModuleBuilder.build()
        vc.modalPresentationStyle = .overFullScreen
        viewController?.present(vc, animated: false) {
            vc.show()
        }
    }
}
