import Foundation

protocol GeneralPresenterProtocol: AnyObject {
    func viewLoaded()
    func dataLoaded(with page: Page)
    func handleCategory()
    func handleSwipe(direction: SwipeDirection)
    func handleFilters()
    func updateFilter(to filter: Filter)
}

class GeneralPresenter {
    // MARK: Module References
    weak var view: GeneralViewProtocol?
    var router: GeneralRouterProtocol
    var interactor: GeneralInteractorProtocol

    // MARK: Variables
    private var category: DataType = .movies
    
    private var page: Page?
    private var filter = Filter(years: (1930, 2030), ratings: (0, 10))

    // MARK: Initialize
    init(interactor: GeneralInteractorProtocol, router: GeneralRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension GeneralPresenter: GeneralPresenterProtocol {
    func viewLoaded() {
        interactor.loadData(of: .movies)
    }
    
    func dataLoaded(with page: Page) {
        self.page = page
        DispatchQueue.main.async {
            if let card = self.page?.currentCard {
                self.view?.show(category: self.category, card: card)
            }
        }
    }
    
    func handleCategory() {
        switch category {
        case .movies:
            category = .series
            DispatchQueue.main.async {
                if let card = self.page?.currentCard {
                    self.view?.show(category: self.category, card: card)
                }
            }
        case .series:
            category = .movies
            DispatchQueue.main.async {
                if let card = self.page?.currentCard {
                    self.view?.show(category: self.category, card: card)
                }
            }
        }
    }
    
    func handleSwipe(direction: SwipeDirection) {
        switch direction {
        case .left:
            print("DEBUG: Свайп влево")
        case .right:
            page?.swiper.step(for: category)
            DispatchQueue.main.async {
                if let card = self.page?.currentCard {
                    self.view?.show(category: self.category, card: card)
                }
            }
        }
    }
    
    func handleFilters() {
        router.openFilters(with: filter, completion: updateFilter)
    }
    
    func updateFilter(to filter: Filter) {
        self.filter = filter
    }
}
