protocol LoginRouterProtocol {
    func openRegister()
}

class LoginRouter: LoginRouterProtocol {
    weak var viewController: LoginViewController?
    
    func openRegister() {
        let vc = RegisterModuleBuilder.build()
        viewController?.present(vc, animated: true)
    }
}
