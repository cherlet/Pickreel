protocol SearchPresenterProtocol: AnyObject {
    func viewLoaded()
    func dataLoaded(with history: [Media])
    func updateSearch(with keyword: String)
    func dataFound(with results: [Media])
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
        //interactor.loadData()
    }
    
    func dataLoaded(with history: [Media]) {
        view?.show(history: history)
    }
    
    func updateSearch(with keyword: String) {
        interactor.searchData(with: keyword)
    }
    
    func dataFound(with results: [Media]) {
        view?.show(results: results)
    }
}
