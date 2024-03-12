import UIKit

protocol ProfileViewProtocol: AnyObject {
    func showSettings()
    func hideSettings()
}

class ProfileViewController: UIViewController {
    // MARK: Variables
    var presenter: ProfilePresenterProtocol?
    var settingsViewController: SettingsViewController?
    
    // MARK: UI Elements
    private let profileView = UIView()
    private let profileAvatar = UIImageView()
    private let profileName = UILabel()
    private let likedSection = UIView()
    private let ratingSection = UIView()
    private let settingsButton = UIButton()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.deselectSettingsButton()
    }
}

// MARK: Module
extension ProfileViewController: ProfileViewProtocol {
    func showSettings() {
        settingsViewController = SettingsModuleBuilder.build()
        guard let settingsViewController = settingsViewController else { return }
        addChild(settingsViewController)
        
        settingsViewController.view.frame = CGRect(x: 0, y: -settingsViewController.view.frame.height, width: view.bounds.width, height: settingsViewController.view.frame.height)
        view.insertSubview(settingsViewController.view, belowSubview: profileView)
        settingsViewController.didMove(toParent: self)

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            settingsViewController.view.frame = CGRect(x: 0, y: self.profileView.frame.maxY, width: settingsViewController.view.frame.width, height: settingsViewController.view.frame.height)
        }, completion: nil)
        
        settingsButton.tintColor = ThemeColor.generalColor
    }

    func hideSettings() {
        guard let settingsViewController = settingsViewController else { return }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            settingsViewController.view.frame = CGRect(x: 0, y: -settingsViewController.view.frame.height, width: settingsViewController.view.frame.width, height: settingsViewController.view.frame.height)
        }) { _ in
            settingsViewController.willMove(toParent: nil)
            settingsViewController.view.removeFromSuperview()
            settingsViewController.removeFromParent()
        }

        settingsButton.tintColor = ThemeColor.backgroundColor
    }
}

// MARK: Setup
private extension ProfileViewController {
    func initialize() {
        view.backgroundColor = ThemeColor.backgroundColor
        setupButtons()
        setupSections()
        setupProfile()
        setupLayout()
    }
    
    func setupLayout() {
        let uiElements = [likedSection, ratingSection, profileView, settingsButton]
        
        uiElements.forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 240),
            
            likedSection.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 24),
            likedSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            likedSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            likedSection.heightAnchor.constraint(equalToConstant: 100),
            
            ratingSection.topAnchor.constraint(equalTo: likedSection.bottomAnchor, constant: 16),
            ratingSection.leadingAnchor.constraint(equalTo: likedSection.leadingAnchor),
            ratingSection.trailingAnchor.constraint(equalTo: likedSection.trailingAnchor),
            ratingSection.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        [profileAvatar, profileName, settingsButton].forEach {
            profileView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            settingsButton.heightAnchor.constraint(equalToConstant: 32),
            settingsButton.widthAnchor.constraint(equalToConstant: 32),
            settingsButton.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 64),
            settingsButton.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -20),
            
            profileAvatar.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 80),
            profileAvatar.widthAnchor.constraint(equalToConstant: 64),
            profileAvatar.heightAnchor.constraint(equalToConstant: 64),
            profileAvatar.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            
            profileName.topAnchor.constraint(equalTo: profileAvatar.bottomAnchor, constant: 16),
            profileName.centerXAnchor.constraint(equalTo: profileAvatar.centerXAnchor)
        ])
        
    }
    
    func setupSections() {
        likedSection.transformToSection(name: "Список", iconName: "list.clipboard")
        ratingSection.transformToSection(name: "Оценки", iconName: "star")
    }
    
    func setupProfile() {
        // later add network layer
        profileView.backgroundColor = ThemeColor.contrastColor
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.layer.cornerRadius = 16
        profileView.isUserInteractionEnabled = true
        
        profileAvatar.image = UIImage(systemName: "person.circle")
        profileAvatar.translatesAutoresizingMaskIntoConstraints = false
        profileAvatar.tintColor = .white
        
        profileName.text = "Usman Gosling"
        profileName.textColor = .white
        profileName.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        profileName.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupButtons() {
        let config = UIImage.SymbolConfiguration(pointSize: 32)
        let image = UIImage(systemName: "gear", withConfiguration: config)
        settingsButton.setImage(image, for: .normal)
        settingsButton.tintColor = ThemeColor.backgroundColor
        settingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.isUserInteractionEnabled = true
    }
    
    // MARK: Actions
    
    @objc func didTapSettingsButton() {
        presenter?.didTapSettingsButton()
    }
}
