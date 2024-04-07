import MultiSlider

protocol FiltersPresenterProtocol: AnyObject {
    func viewLoaded()
    func yearSliderChanged(slider: MultiSlider)
    func ratingSliderChanged(slider: MultiSlider)
    func handleSubmit(genre: String?)
}

class FiltersPresenter {
    weak var view: FiltersViewProtocol?
    var router: FiltersRouterProtocol
    
    private var filter: Filter
    private var completion: (Filter) -> Void

    init(router: FiltersRouterProtocol, filter: Filter, completion: @escaping (Filter) -> Void) {
        self.router = router
        self.filter = filter
        self.completion = completion
    }
}

extension FiltersPresenter: FiltersPresenterProtocol {
    func viewLoaded() {
        view?.update(filter: filter)
    }
    
    func yearSliderChanged(slider: MultiSlider) {
        filter.years = (Int(slider.value[0]), Int(slider.value[1]))
        view?.update(filter: filter)
    }
    
    func ratingSliderChanged(slider: MultiSlider) {
        filter.ratings = (Double(slider.value[0] * 10).rounded() / 10, Double(slider.value[1] * 10).rounded() / 10)
        view?.update(filter: filter)
    }
    
    func handleSubmit(genre: String?) {
        filter.genre = genre
        router.closeFilters(newFilter: Filter(years: filter.years, ratings: filter.ratings, genre: filter.genre), completion: completion)
    }
}
