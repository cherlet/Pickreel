import MultiSlider

protocol FiltersPresenterProtocol: AnyObject {
    func viewLoaded()
    func yearSliderChanged(slider: MultiSlider)
    func ratingSliderChanged(slider: MultiSlider)
    func didTapSubmitButton()
}

class FiltersPresenter {
    weak var view: FiltersViewProtocol?
    var router: FiltersRouterProtocol
    
    private var years: (Int, Int)
    private var ratings: (Double, Double)
    private var genre: String?
    private var completion: (Filter) -> Void

    init(router: FiltersRouterProtocol, filter: Filter, completion: @escaping (Filter) -> Void) {
        self.router = router
        self.years = filter.years ?? (1930, 2030)
        self.ratings = filter.ratings ?? (0.0, 10.0)
        self.genre = filter.genre
        self.completion = completion
    }
}

extension FiltersPresenter: FiltersPresenterProtocol {
    func viewLoaded() {
        view?.update(years: years)
        view?.update(ratings: ratings)
    }
    
    func yearSliderChanged(slider: MultiSlider) {
        years = (Int(slider.value[0]), Int(slider.value[1]))
        view?.update(years: years)
    }
    
    func ratingSliderChanged(slider: MultiSlider) {
        ratings = (Double(slider.value[0] * 10).rounded() / 10, Double(slider.value[1] * 10).rounded() / 10)
        view?.update(ratings: ratings)
    }
    
    func didTapSubmitButton() {
        router.closeFilters(newFilter: Filter(years: years, ratings: ratings, genre: genre), completion: completion)
    }
}
