import UIKit

protocol GeneralViewProtocol: AnyObject {
}

class GeneralViewController: UIViewController {
    var presenter: GeneralPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

private extension GeneralViewController {
    func initialize() {
        view.backgroundColor = .black
    }
}

extension GeneralViewController: GeneralViewProtocol {
}
