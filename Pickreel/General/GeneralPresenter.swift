import Foundation

protocol GeneralPresenterProtocol: AnyObject {
    func viewLoaded()
    
    func didTapFilmCategory()
    func didTapSeriesCategory()
    
    func didTapFiltersButton()
    func updateFilter(to filter: Filter)
}

class GeneralPresenter {
    weak var view: GeneralViewProtocol?
    var router: GeneralRouterProtocol
    var interactor: GeneralInteractorProtocol

    private var filter = Filter(years: (1930, 2030), ratings: (0, 10))

    init(interactor: GeneralInteractorProtocol, router: GeneralRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension GeneralPresenter: GeneralPresenterProtocol {
    
    func viewLoaded() {
        // TODO: - Load content data to present
    }
    
    func didTapFilmCategory() {
        Task {
            await NetworkManager.shared.checkMoviesCount()
        }
    }
    
    func didTapSeriesCategory() {
        Task {
            await NetworkManager.shared.checkSeriesCount()
        }
    }
    
    func didTapFiltersButton() {
        // TODO: - Implement filtration
        router.openFilters(with: filter, completion: updateFilter)
    }
    
    func updateFilter(to filter: Filter) {
        self.filter = filter
    }
}
