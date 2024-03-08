import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func didTapSignInButton(_ email: String, _ password: String)
    func didTapRegisterButton()
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
    func didTapSignInButton(_ email: String, _ password: String) {
        interactor.didTapSignInButton(email, password)
    }
    
    func didTapRegisterButton() {
        router.openRegister()
    }
    
    func didSignIn() {
        router.openApp()
    }
}
