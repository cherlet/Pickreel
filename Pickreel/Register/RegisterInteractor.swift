protocol RegisterInteractorProtocol: AnyObject {
}

class RegisterInteractor: RegisterInteractorProtocol {
    weak var presenter: RegisterPresenterProtocol?
}
