protocol GeneralInteractorProtocol: AnyObject {
    func loadData(with filter: Filter?)
    func sendChoice(of card: Card, with type: MediaType)
    func resetIterator()
}

class GeneralInteractor: GeneralInteractorProtocol {
    weak var presenter: GeneralPresenterProtocol?
    
    func loadData(with filter: Filter?) {
        Task {
            await NetworkManager.shared.loadData(with: filter)
            if let page = NetworkManager.shared.currentPage {
                presenter?.dataLoaded(with: page)
            }
        }
    }
    
    func sendChoice(of card: Card, with type: MediaType) {
        Task {
            await NetworkManager.shared.writeChoice(of: card, with: type)
        }
    }
    
    func resetIterator() {
        NetworkManager.shared.iterator.reset()
    }
}


