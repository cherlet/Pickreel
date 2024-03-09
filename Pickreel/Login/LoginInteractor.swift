protocol LoginInteractorProtocol: AnyObject {
    func didTapSignInButton(_ email: String, _ password: String)
}

class LoginInteractor: LoginInteractorProtocol {
    weak var presenter: LoginPresenterProtocol?
    
    func didTapSignInButton(_ email: String, _ password: String) {
        Task {
            try await NetworkManager.shared.signIn(withEmail: email, password: password)
        }
        
        if NetworkManager.shared.userSession != nil {
            presenter?.didSignIn()
        }
    }
}
