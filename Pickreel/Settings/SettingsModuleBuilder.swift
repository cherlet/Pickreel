import UIKit

class SettingsModuleBuilder {
    static func build() -> SettingsViewController {
        let interactor = SettingsInteractor()
        let router = SettingsRouter()
        let presenter = SettingsPresenter(interactor: interactor, router: router)
        let viewController = SettingsViewController()

        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController

        return viewController
    }
}
