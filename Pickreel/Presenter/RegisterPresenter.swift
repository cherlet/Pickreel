protocol RegisterPresenterProtocol: AnyObject {
    func handleSignUp(_ email: String, _ password: String, _ nickname: String)
    func handleCancel()
    func didSignUp(_ email: String, _ password: String)
}

class RegisterPresenter {
    weak var view: RegisterViewProtocol?
    var interactor: RegisterInteractorProtocol

    init(interactor: RegisterInteractorProtocol) {
        self.interactor = interactor
    }
}

extension RegisterPresenter: RegisterPresenterProtocol {
    func handleSignUp(_ email: String, _ password: String, _ nickname: String) {
        interactor.handleSignUp(email, password, nickname)
    }
    
    func didSignUp(_ email: String, _ password: String) {
        view?.hide(email, password)
    }
    
    func handleCancel() {
        view?.hide(nil, nil)
    }
}
