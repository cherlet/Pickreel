import UIKit

protocol RegisterViewProtocol: AnyObject {
}

class RegisterViewController: UIViewController {
    var presenter: RegisterPresenterProtocol?

    // MARK: UI Elements
    

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: Module 
extension RegisterViewController: RegisterViewProtocol {
}

// MARK: Setup
private extension RegisterViewController {
    func initialize() {
        view.backgroundColor = .red
    }
}
