protocol SearchInteractorProtocol: AnyObject {
    func loadData()
}

class SearchInteractor: SearchInteractorProtocol {
    weak var presenter: SearchPresenterProtocol?
    
    func loadData() {
        Task {
            let history = await NetworkManager.shared.fetchHistory()
            presenter?.dataLoaded(with: history)
        }
    }
}
