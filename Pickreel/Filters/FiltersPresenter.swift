protocol FiltersPresenterProtocol: AnyObject {
}

class FiltersPresenter {
    weak var view: FiltersViewProtocol?
    var router: FiltersRouterProtocol
    var interactor: FiltersInteractorProtocol

    init(interactor: FiltersInteractorProtocol, router: FiltersRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension FiltersPresenter: FiltersPresenterProtocol {
}
