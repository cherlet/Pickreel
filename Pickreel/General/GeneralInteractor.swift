protocol GeneralInteractorProtocol: AnyObject {
}

class GeneralInteractor: GeneralInteractorProtocol {
    weak var presenter: GeneralPresenterProtocol?
}
