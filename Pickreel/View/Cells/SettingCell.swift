import UIKit

class SettingCell: UICollectionViewCell {
    // MARK: Properties
    static let identifier = "SettingCell"
    
    // MARK: UI Elements
    private lazy var icon = UIImageView(iconColor: ThemeColor.opp)
    private lazy var label = UILabel(textColor: ThemeColor.opp, fontSize: 20)
    private lazy var arrowIcon = UIImageView(iconName: "chevron.right", iconColor: ThemeColor.contrast, isHidden: true)
    
    private let toggleSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.onTintColor = ThemeColor.general
        toggleSwitch.isHidden = true
        toggleSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        return toggleSwitch
    }()
    
    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = ThemeColor.tableFront
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
    
    private func setup(iconName: String, text: String, type: SettingType? = nil) {
        icon.image = UIImage(systemName: iconName)
        label.text = text
        
        if let type = type {
            switch type {
            case .danger:
                icon.tintColor = ThemeColor.red
                label.textColor = ThemeColor.red
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
            setup(iconName: "arrow.triangle.2.circlepath.camera", text: setting.rawValue)
        case .toggleTheme:
            setup(iconName: "moon", text: setting.rawValue, type: .toggle)
        case .personalData:
            setup(iconName: "pencil", text: setting.rawValue, type: .container)
        case .signOut:
            setup(iconName: "arrowshape.left", text: setting.rawValue, type: .danger)
        case .resetAccount:
            setup(iconName: "gobackward", text: setting.rawValue, type: .danger)
        case .deleteAccount:
            setup(iconName: "clear", text: setting.rawValue, type: .danger)
        }
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


