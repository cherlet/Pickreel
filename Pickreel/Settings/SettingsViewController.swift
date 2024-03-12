import UIKit

protocol SettingsViewProtocol: AnyObject {
}

class SettingsViewController: UIViewController {
    // MARK: Variables
    var presenter: SettingsPresenterProtocol?
    private var settingsSections: [[Setting]] = []
    
    // MARK: UI Elements
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = ThemeColor.tableBackColor
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: SettingCell.identifier)
        return collectionView
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        settingsSections = [
            [.changeAvatar, .personalData], // Section 1
            [.toggleTheme], // Section 2
            [.signOut, .resetAccount, .deleteAccount] // Section 3
        ]
    }
}

// MARK: Module
extension SettingsViewController: SettingsViewProtocol {
}

// MARK: Setup
private extension SettingsViewController {
    func initialize() {
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: Actions
}

// MARK: CollectionView
extension SettingsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return settingsSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsSections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell else {
            fatalError("DEBUG: Failed with custom cell bug")
        }
        
        let setting = settingsSections[indexPath.section][indexPath.item]
        cell.configure(setting: setting)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3.2
    }
}

// MARK: Settings Enum
enum Setting: String, CaseIterable {
    case changeAvatar = "Изменить фотографию"
    case toggleTheme = "Темная тема"
    case personalData = "Личные данные"
    case signOut = "Выйти"
    case resetAccount = "Сбросить аккаунт"
    case deleteAccount = "Удалить аккаунт"
}

