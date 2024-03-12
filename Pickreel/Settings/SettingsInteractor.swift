protocol SettingsInteractorProtocol: AnyObject {
    func handleSignOut()
    func handleAccountDeletion()
}

class SettingsInteractor: SettingsInteractorProtocol {
    weak var presenter: SettingsPresenterProtocol?
    
    func handleSignOut() {
        NetworkManager.shared.signOut()
        presenter?.didSignOut()
    }
    
    func handleAccountDeletion() {
        NetworkManager.shared.deleteAccount()
        presenter?.didSignOut()
    }
}
