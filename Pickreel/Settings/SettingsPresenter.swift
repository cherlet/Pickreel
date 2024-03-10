protocol SettingsPresenterProtocol: AnyObject {
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
}
