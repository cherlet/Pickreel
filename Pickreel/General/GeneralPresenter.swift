protocol GeneralPresenterProtocol: AnyObject {
    func viewLoaded()
    func didTapFilmCategory()
    func didTapSeriesCategory()
}

class GeneralPresenter {
    weak var view: GeneralViewProtocol?
    var router: GeneralRouterProtocol
    var interactor: GeneralInteractorProtocol
    
    private var isFilmCategory = true

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
        guard !isFilmCategory else { return }
        view?.showFilm()
        isFilmCategory = true
    }
    
    func didTapSeriesCategory() {
        guard isFilmCategory else { return }
        view?.showSeries()
        isFilmCategory = false
    }
}
