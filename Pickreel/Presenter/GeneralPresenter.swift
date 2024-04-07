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
    
    // MARK: Properties
    private var category: MediaType = .movies
    
    private var page: Page?
    private var filter = Filter()
    
    // MARK: Initialize
    init(interactor: GeneralInteractorProtocol, router: GeneralRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension GeneralPresenter: GeneralPresenterProtocol {
    func viewLoaded() {
        interactor.loadData(with: filter)
    }
    
    func dataLoaded(with page: Page) {
        self.page = page
        guard let card = self.page?.currentCard else { return }
        view?.show(category: self.category, card: card)
    }
    
    func handleCategory() {
        guard let card = self.page?.currentCard else { return }
        interactor.resetIterator()
        category = category.getOpposite()
        view?.show(category: self.category, card: card)
    }
    
    func handleSwipe(direction: SwipeDirection) {
        // Write swipe choice
        guard let currentCard = self.page?.currentCard else { return }
        interactor.sendChoice(of: currentCard, with: category)
        
        // Swipe card
        page?.data.swiper.step(for: category)
        guard let card = self.page?.currentCard else { return }
        view?.show(category: self.category, card: card)
    }
    
    func handleFilters() {
        router.openFilters(with: filter, completion: updateFilter)
    }
    
    func updateFilter(to filter: Filter) {
        self.filter = filter
        interactor.loadData(with: filter)
    }
}
