protocol GeneralPresenterProtocol: AnyObject {
    func viewLoaded()
    func didTapFilmCategory()
    func didTapSeriesCategory()
    func setContent(_ content: Content)
}

class GeneralPresenter {
    weak var view: GeneralViewProtocol?
    var router: GeneralRouterProtocol
    var interactor: GeneralInteractorProtocol
    
    private var isFilmCategory = true
    private var content = Content(name: "", year: 0, rating: 0, countries: [], genres: [], poster: "")

    init(interactor: GeneralInteractorProtocol, router: GeneralRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension GeneralPresenter: GeneralPresenterProtocol {
    func viewLoaded() {
        interactor.loadFilms()
        interactor.prepareContent()
        view?.show(film: content)
    }
    
    func didTapFilmCategory() {
        guard !isFilmCategory else { return }
        interactor.loadFilms()
        view?.show(film: content)
        isFilmCategory = true
    }
    
    func didTapSeriesCategory() {
        guard isFilmCategory else { return }
        interactor.loadSeries()
        view?.show(series: content)
        isFilmCategory = false
    }
    
    func setContent(_ content: Content) {
        self.content = content
    }
}
