import UIKit

protocol SettingsViewProtocol: AnyObject {
}

class SettingsViewController: UIViewController {
    var presenter: SettingsPresenterProtocol?

    // MARK: UI Elements

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: Module 
extension SettingsViewController: SettingsViewProtocol {
}

// MARK: Setup
private extension SettingsViewController {
    func initialize() {
        view.backgroundColor = .red
    }
    
    // MARK: Actions
}
