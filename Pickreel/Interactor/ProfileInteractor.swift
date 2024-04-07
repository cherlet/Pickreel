protocol ProfileInteractorProtocol: AnyObject {
    func getUser() -> User?
}

class ProfileInteractor: ProfileInteractorProtocol {
    weak var presenter: ProfilePresenterProtocol?
    
    func getUser() -> User? {
        return NetworkManager.shared.currentUser
    }
}
