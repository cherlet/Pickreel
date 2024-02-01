protocol FiltersInteractorProtocol: AnyObject {
}

class FiltersInteractor: FiltersInteractorProtocol {
    weak var presenter: FiltersPresenterProtocol?
}
