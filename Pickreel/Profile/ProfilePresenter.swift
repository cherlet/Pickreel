protocol ProfilePresenterProtocol: AnyObject {
    func didTapSettingsButton()
    func deselectSettingsButton()
}

class ProfilePresenter {
    weak var view: ProfileViewProtocol?
    var router: ProfileRouterProtocol
    var interactor: ProfileInteractorProtocol
    
    var isSettingsVisible: Bool = false

    init(interactor: ProfileInteractorProtocol, router: ProfileRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
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
