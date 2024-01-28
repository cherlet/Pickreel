import Foundation

protocol GeneralPresenterProtocol: AnyObject {
    func viewLoaded()
    func didTapFilmCategory()
    func didTapSeriesCategory()
    func didLoad(films: [Content])
    func didLoad(series: [Content])
}

class GeneralPresenter {
    weak var view: GeneralViewProtocol?
    var router: GeneralRouterProtocol
    var interactor: GeneralInteractorProtocol
    
    private var isFilmCategory = true
    private var iterator = 0
    private var films: [Content] = []
    private var series: [Content] = []

    init(interactor: GeneralInteractorProtocol, router: GeneralRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension GeneralPresenter: GeneralPresenterProtocol {
    
    func viewLoaded() {
        interactor.loadFilms()
        interactor.loadSeries()
    }
    
    func didTapFilmCategory() {
        guard !isFilmCategory else { return }
        isFilmCategory = true
        iterator += 1
        view?.show(film: films[iterator])
    }
    
    func didTapSeriesCategory() {
        guard isFilmCategory else { return }
        isFilmCategory = false
        iterator += 1
        view?.show(series: series[iterator])
    }
    
    func didLoad(films: [Content]) {
        self.films = films
        DispatchQueue.main.async {
            self.view?.show(film: films[self.iterator])
        }
    }
    
    func didLoad(series: [Content]) {
        self.series = series
    }
}
