protocol GeneralPresenterProtocol: AnyObject {
    func viewLoaded()
    func didTapFilmCategory()
    func didTapSeriesCategory()
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
    func viewLoaded() {
        interactor.loadContent()
    }
    
    func didTapFilmCategory() {
        view?.showFilm()
    }
    
    func didTapSeriesCategory() {
        view?.showSeries()
    }
}
