protocol SettingsPresenterProtocol: AnyObject {
    func handleAvatarChange()
    func handlePersonalData()
    func handleThemeToggle()
    
    func handleSignOut()
    func didSignOut()
    
    func handleAccountReset()
    func handleAccountDeletion()
}

class SettingsPresenter {
    weak var view: SettingsViewProtocol?
    var router: SettingsRouterProtocol
    var interactor: SettingsInteractorProtocol

    init(interactor: SettingsInteractorProtocol, router: SettingsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension SettingsPresenter: SettingsPresenterProtocol {
    func handleAvatarChange() {
        //
    }
    
    func handlePersonalData() {
        //
    }
    
    func handleThemeToggle() {
        //
    }
    
    func handleSignOut() {
        interactor.signOut()
    }
    
    func didSignOut() {
        router.openLogin()
    }
    
    func handleAccountReset() {
        interactor.resetAccount()
    }
    
    func handleAccountDeletion() {
        interactor.deleteAccount()
    }
}
