protocol LoginInteractorProtocol: AnyObject {
}

class LoginInteractor: LoginInteractorProtocol {
    weak var presenter: LoginPresenterProtocol?
}
