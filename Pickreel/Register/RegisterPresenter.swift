protocol RegisterPresenterProtocol: AnyObject {
    func didTapSubmitButton(_ email: String, _ password: String)
    func didTapCancel()
    func didSignUp(_ email: String, _ password: String)
}

class RegisterPresenter {
    weak var view: RegisterViewProtocol?
    var router: RegisterRouterProtocol
    var interactor: RegisterInteractorProtocol

    init(interactor: RegisterInteractorProtocol, router: RegisterRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension RegisterPresenter: RegisterPresenterProtocol {
    func didTapSubmitButton(_ email: String, _ password: String) {
        //
    }
    
    func didSignUp(_ email: String, _ password: String) {
        view?.hide(email, password)
    }
    
    func didTapCancel() {
        view?.hide(nil, nil)
    }
}
