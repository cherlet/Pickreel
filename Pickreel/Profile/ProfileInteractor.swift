protocol ProfileInteractorProtocol: AnyObject {
}

class ProfileInteractor: ProfileInteractorProtocol {
    weak var presenter: ProfilePresenterProtocol?
}
