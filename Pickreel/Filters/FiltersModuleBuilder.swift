import UIKit

class FiltersModuleBuilder {
    static func build(with config: Filter, completion: @escaping (Filter) -> Void) -> FiltersViewController {
        let router = FiltersRouter()
        let presenter = FiltersPresenter(router: router, filter: config, completion: completion)
        let viewController = FiltersViewController()

        presenter.view  = viewController
        viewController.presenter = presenter
        router.viewController = viewController

        return viewController
    }
}
