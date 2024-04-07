protocol ProfilePresenterProtocol: AnyObject {
    func viewLoaded()
    func didTapSettingsButton()
    func deselectSettingsButton()
}

class ProfilePresenter {
    weak var view: ProfileViewProtocol?
    var router: ProfileRouterProtocol
    var interactor: ProfileInteractorProtocol
    
    var isSettingsVisible = false

    init(interactor: ProfileInteractorProtocol, router: ProfileRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func viewLoaded() {
        let user = interactor.getUser()
        view?.initializeUser(user: user)
    }
    
    func didTapSettingsButton() {
        if isSettingsVisible {
            view?.hideSettings()
            isSettingsVisible = false
        } else {
            view?.showSettings()
            isSettingsVisible = true
        }
    }
    
    func deselectSettingsButton() {
        if isSettingsVisible {
            view?.hideSettings()
            isSettingsVisible = false
        }
    }
}
