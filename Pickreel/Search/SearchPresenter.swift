protocol SearchPresenterProtocol: AnyObject {
    func viewLoaded()
    func dataLoaded(with history: [Media])
}

class SearchPresenter {
    weak var view: SearchViewProtocol?
    var router: SearchRouterProtocol
    var interactor: SearchInteractorProtocol

    init(interactor: SearchInteractorProtocol, router: SearchRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    func viewLoaded() {
        interactor.loadData()
    }
    
    func dataLoaded(with history: [Media]) {
        view?.initializeTable(with: history)
    }
}
