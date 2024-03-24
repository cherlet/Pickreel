import UIKit

class SettingCell: UICollectionViewCell {
    // MARK: Properties
    static let identifier = "SettingCell"
    
    // MARK: UI Elements
    private let icon = UIImageView(image: UIImage(systemName: "circle"))
    private let label = UILabel()
    private let toggleSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.onTintColor = ThemeColor.generalColor
        toggleSwitch.isHidden = true
        toggleSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        return toggleSwitch
    }()
    
    private let arrowIcon: UIImageView = {
        let image = UIImage(systemName: "chevron.right")
        let imageView = UIImageView(image: image)
        imageView.tintColor = ThemeColor.contrastColor
        imageView.isHidden = true
        return imageView
    }()
    
    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = ThemeColor.tableFrontColor
        contentView.layer.cornerRadius = 8
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setupLayout() {
        let uiElements = [icon, label, toggleSwitch, arrowIcon]
        
        uiElements.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            label.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 56),
            
            toggleSwitch.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            toggleSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            arrowIcon.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            arrowIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupUI(iconName: String, text: String, type: SettingType? = nil) {
        icon.image = UIImage(systemName: iconName)
        icon.tintColor = ThemeColor.oppColor
        
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = ThemeColor.oppColor
        
        if let type = type {
            switch type {
            case .danger:
                icon.tintColor = ThemeColor.redGradientSecond
                label.textColor = ThemeColor.redGradientSecond
            case .toggle:
                toggleSwitch.isHidden = false
                if ThemeManager.shared.currentTheme == .dark {
                    toggleSwitch.isOn = true
                }
            case .container:
                arrowIcon.isHidden = false
            }
        }
    }
    
    public func configure(setting: Setting) {
        switch setting {
        case .changeAvatar:
            setupUI(iconName: "arrow.triangle.2.circlepath.camera", text: setting.rawValue)
        case .toggleTheme:
            setupUI(iconName: "moon", text: setting.rawValue, type: .toggle)
        case .personalData:
            setupUI(iconName: "pencil", text: setting.rawValue, type: .container)
        case .signOut:
            setupUI(iconName: "arrowshape.left", text: setting.rawValue, type: .danger)
        case .resetAccount:
            setupUI(iconName: "gobackward", text: setting.rawValue, type: .danger)
        case .deleteAccount:
            setupUI(iconName: "clear", text: setting.rawValue, type: .danger)
        }
    }
    
    // MARK: Setting Type Enum
    enum SettingType {
        case danger
        case toggle
        case container
    }
    
    // MARK: Theme Switch
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            ThemeManager.shared.currentTheme = .dark
        } else {
            ThemeManager.shared.currentTheme = .light
        }
        ThemeManager.shared.applyTheme()
    }
}


