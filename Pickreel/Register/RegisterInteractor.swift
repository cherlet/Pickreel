protocol RegisterInteractorProtocol: AnyObject {
    func handleSignUp(_ email: String, _ password: String, _ nickname: String)
}

class RegisterInteractor: RegisterInteractorProtocol {
    weak var presenter: RegisterPresenterProtocol?
    
    func handleSignUp(_ email: String, _ password: String, _ nickname: String) {
        Task {
            try await NetworkManager.shared.createUser(withEmail: email, password: password, nickname: nickname)
        }
        presenter?.didSignUp(email, password)
    }
}
