protocol GeneralPresenterProtocol: AnyObject {
}

class GeneralPresenter {
    weak var view: GeneralViewProtocol?
    var router: GeneralRouterProtocol
    var interactor: GeneralInteractorProtocol

    init(interactor: GeneralInteractorProtocol, router: GeneralRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension GeneralPresenter: GeneralPresenterProtocol {
}
