import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func handleSignIn(_ email: String, _ password: String)
    func handleRegister()
    func didSignIn()
}

class LoginPresenter {
    weak var view: LoginViewProtocol?
    var router: LoginRouterProtocol
    var interactor: LoginInteractorProtocol

    init(interactor: LoginInteractorProtocol, router: LoginRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func handleSignIn(_ email: String, _ password: String) {
        interactor.handleSignIn(email, password)
    }
    
    func handleRegister() {
        router.openRegister()
    }
    
    func didSignIn() {
        router.openApp()
    }
}
