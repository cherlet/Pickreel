import Foundation

protocol GeneralPresenterProtocol: AnyObject {
    func viewLoaded()
    func didTapFilmCategory()
    func didTapSeriesCategory()
    func didTapFiltersButton()
    func didLoad(films: [Content])
    func didLoad(series: [Content])
    func updateFilter(to filter: Filter)
}

class GeneralPresenter {
    weak var view: GeneralViewProtocol?
    var router: GeneralRouterProtocol
    var interactor: GeneralInteractorProtocol
    
    private var isFilmCategory = true
    private var iterator = 0
    private var films: [Content] = []
    private var series: [Content] = []
    private var filter = Filter(years: (1930, 2030), ratings: (0, 10))
    
    private var tempFilms: [Content] = []
    private var tempSeries: [Content] = []

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
        
        let film = tempFilms[iterator]
        view?.show(film: film)
            
        iterator += 1
    }
    
    func didTapSeriesCategory() {
        guard isFilmCategory else { return }
        isFilmCategory = false
        
        let series = tempSeries[iterator]
        view?.show(series: series)
            
        iterator += 1
    }
    
    func didTapFiltersButton() {
        router.openFilters(with: filter, completion: updateFilter)
    }
    
    func didLoad(films: [Content]) {
        self.films = films
        self.tempFilms = films
        DispatchQueue.main.async {
            self.view?.show(film: films[self.iterator])
        }
    }
    
    func didLoad(series: [Content]) {
        self.series = series
        self.tempSeries = series
    }
    
    func updateFilter(to filter: Filter) {
        self.filter = filter
        
        iterator = 0
        tempFilms = films.filter { $0.isAllowed(filter: self.filter) }
        tempSeries = series.filter { $0.isAllowed(filter: self.filter) }
        
        if isFilmCategory {
            view?.show(film: tempFilms[iterator])
        } else {
            view?.show(series: tempSeries[iterator])
        }
    }
}
