protocol GeneralInteractorProtocol: AnyObject {
    func loadData(of: DataType)
}

class GeneralInteractor: GeneralInteractorProtocol {
    weak var presenter: GeneralPresenterProtocol?
    
    func loadData(of: DataType) {
        Task {
            await NetworkManager.shared.fetchData()
            if let page = NetworkManager.shared.currentPage {
                presenter?.dataLoaded(with: page)
            }
        }
    }
}


