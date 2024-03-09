protocol RegisterInteractorProtocol: AnyObject {
    func didTapSubmitButton(_ email: String, _ password: String, _ nickname: String)
}

class RegisterInteractor: RegisterInteractorProtocol {
    weak var presenter: RegisterPresenterProtocol?
    
    func didTapSubmitButton(_ email: String, _ password: String, _ nickname: String) {
        //NetworkManager.shared.createUser(withEmail: email, password: password, nickname: nickname)
        presenter?.didSignUp(email, password)
    }
}
