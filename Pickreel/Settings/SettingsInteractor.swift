protocol SettingsInteractorProtocol: AnyObject {
    func signOut()
    func deleteAccount()
    func resetAccount()
}

class SettingsInteractor: SettingsInteractorProtocol {
    weak var presenter: SettingsPresenterProtocol?
    
    func signOut() {
        NetworkManager.shared.signOut()
        presenter?.didSignOut()
    }
    
    func deleteAccount() {
        Task {
            await NetworkManager.shared.deleteAccount()
            presenter?.didSignOut()
        }
    }
    
    func resetAccount() {
        Task {
            await NetworkManager.shared.clearHistory()
        }
    }
}
