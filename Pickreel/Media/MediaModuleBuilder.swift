import UIKit

class MediaModuleBuilder {
    static func build(for media: Media) -> MediaViewController {
        let presenter = MediaPresenter(media: media)
        let viewController = MediaViewController()

        presenter.view  = viewController
        viewController.presenter = presenter

        return viewController
    }
}
