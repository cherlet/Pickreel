import UIKit

class GeneralModuleBuilder {
    static func build() -> GeneralViewController {
        let interactor = GeneralInteractor()
        let router = GeneralRouter()
        let presenter = GeneralPresenter(interactor: interactor, router: router)
        let viewController = GeneralViewController()
        
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}
