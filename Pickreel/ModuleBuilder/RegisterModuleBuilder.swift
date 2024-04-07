import UIKit

class RegisterModuleBuilder {
    static func build() -> RegisterViewController {
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter(interactor: interactor)
        let viewController = RegisterViewController()

        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter

        return viewController
    }
}
