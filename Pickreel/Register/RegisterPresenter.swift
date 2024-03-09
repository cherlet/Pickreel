protocol RegisterPresenterProtocol: AnyObject {
    func didTapSubmitButton(_ email: String, _ password: String, _ nickname: String)
    func didTapCancel()
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
    func didTapSubmitButton(_ email: String, _ password: String, _ nickname: String) {
        interactor.didTapSubmitButton(email, password, nickname)
    }
    
    func didSignUp(_ email: String, _ password: String) {
        view?.hide(email, password)
    }
    
    func didTapCancel() {
        view?.hide(nil, nil)
    }
}
