protocol GeneralInteractorProtocol: AnyObject {
    func loadData()
    func sendChoice(of card: Card, with type: DataType)
}

class GeneralInteractor: GeneralInteractorProtocol {
    weak var presenter: GeneralPresenterProtocol?
    
    func loadData() {
        Task {
            await NetworkManager.shared.fetchData()
            if let page = NetworkManager.shared.currentPage {
                presenter?.dataLoaded(with: page)
            }
        }
    }
    
    func sendChoice(of card: Card, with type: DataType) {
        Task {
            await NetworkManager.shared.writeChoice(of: card, with: type)
        }
    }
}


