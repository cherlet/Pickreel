protocol SearchInteractorProtocol: AnyObject {
}

class SearchInteractor: SearchInteractorProtocol {
    weak var presenter: SearchPresenterProtocol?
}
