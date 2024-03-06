protocol RegisterPresenterProtocol: AnyObject {
    func didTapSubmitButton()
    func didTapCancel()
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
    func didTapSubmitButton() {
        view?.hide()
    }
    
    func didTapCancel() {
        view?.hide()
    }
}
