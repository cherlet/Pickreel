import MultiSlider

protocol FiltersPresenterProtocol: AnyObject {
    func viewLoaded()
    func yearSliderChanged(slider: MultiSlider)
    func ratingSliderChanged(slider: MultiSlider)
}

class FiltersPresenter {
    weak var view: FiltersViewProtocol?
    var router: FiltersRouterProtocol
    var interactor: FiltersInteractorProtocol
    
    private var yearLeftValue = 1930
    private var yearRightValue = 2030
    private var ratingLeftValue: Double = 0
    private var ratingRightValue: Double = 10

    init(interactor: FiltersInteractorProtocol, router: FiltersRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension FiltersPresenter: FiltersPresenterProtocol {
    func viewLoaded() {
        view?.update(years: (yearLeftValue, yearRightValue))
        view?.update(ratings: (ratingLeftValue, ratingRightValue))
    }
    
    func yearSliderChanged(slider: MultiSlider) {
        yearLeftValue = Int(slider.value[0])
        yearRightValue = Int(slider.value[1])
        view?.update(years: (yearLeftValue, yearRightValue))
    }
    
    func ratingSliderChanged(slider: MultiSlider) {
        ratingLeftValue = Double(slider.value[0] * 10).rounded() / 10
        ratingRightValue = Double(slider.value[1] * 10).rounded() / 10
        view?.update(ratings: (ratingLeftValue, ratingRightValue))
    }
}
