import UIKit

protocol ProfileViewProtocol: AnyObject {
}

class ProfileViewController: UIViewController {
    var presenter: ProfilePresenterProtocol?

    // MARK: UI Elements
    let tempLabel = UILabel()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: Module 
extension ProfileViewController: ProfileViewProtocol {
}

// MARK: Setup
private extension ProfileViewController {
    func initialize() {
        view.backgroundColor = ThemeColor.backgroundColor
        tempLabel.text = "COMING SOON"
        tempLabel.textColor = ThemeColor.oppColor
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tempLabel)
        tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tempLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
