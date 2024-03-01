protocol RegisterPresenterProtocol: AnyObject {
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
}
