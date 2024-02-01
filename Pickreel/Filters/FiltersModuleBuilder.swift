import UIKit

class FiltersModuleBuilder {
    static func build() -> FiltersViewController {
        let interactor = FiltersInteractor()
        let router = FiltersRouter()
        let presenter = FiltersPresenter(interactor: interactor, router: router)
        let viewController = FiltersViewController()

        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController

        return viewController
    }
}
