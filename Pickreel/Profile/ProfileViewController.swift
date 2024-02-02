import UIKit

protocol ProfileViewProtocol: AnyObject {
}

class ProfileViewController: UIViewController {
    var presenter: ProfilePresenterProtocol?

    // MARK: UI Elements
    private let profileView = UIView()
    private let profileAvatar = UIImageView()
    private let profileName = UILabel()
    private let likedSection = UIView()
    private let ratingSection = UIView()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        likedSection.setGradient(colors: (ThemeColor.greenGradientFirst, ThemeColor.greenGradientSecond))
//    }
}

// MARK: Module 
extension ProfileViewController: ProfileViewProtocol {
}

// MARK: Setup
private extension ProfileViewController {
    func initialize() {
        view.backgroundColor = ThemeColor.backgroundColor
        setupSections()
        setupProfile()
        setupLayout()
    }
    
    func setupLayout() {
        let uiElements = [profileView, likedSection, ratingSection]
        
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
        
        [profileAvatar, profileName].forEach {
            profileView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
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
        
        profileAvatar.image = UIImage(systemName: "person.circle")
        profileAvatar.translatesAutoresizingMaskIntoConstraints = false
        profileAvatar.tintColor = .white
        
        profileName.text = "Usman Gosling"
        profileName.textColor = .white
        profileName.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        profileName.translatesAutoresizingMaskIntoConstraints = false
    }
}
