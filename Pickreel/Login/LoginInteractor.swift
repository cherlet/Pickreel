protocol LoginInteractorProtocol: AnyObject {
    func didTapSignInButton(_ email: String, _ password: String)
}

class LoginInteractor: LoginInteractorProtocol {
    weak var presenter: LoginPresenterProtocol?
    
    func didTapSignInButton(_ email: String, _ password: String) {
        do {
            //NetworkManager.shared.signIn(withEmail: email, password: password)
            presenter?.didSignIn()
        } catch {
            print("DEBUG: User auth failed with error: \(error.localizedDescription)")
        }
    }
}
