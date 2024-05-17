protocol SearchInteractorProtocol: AnyObject {
//    func loadData()
    func searchData(with keyword: String)
}

class SearchInteractor: SearchInteractorProtocol {
    weak var presenter: SearchPresenterProtocol?
    
//    func loadData() {
//        Task {
//            let history = await NetworkManager.shared.fetchHistory()
//            presenter?.dataLoaded(with: history)
//        }
//    }
    
    func searchData(with keyword: String) {
        Task {
            let data = await NetworkManager.shared.searchData(with: keyword)
            presenter?.dataFound(with: data)
        }
    }
}
