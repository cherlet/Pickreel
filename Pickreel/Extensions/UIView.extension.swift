import UIKit

extension UIView {
    convenience init(color: UIColor? = ThemeColor.background, isUserInteraction: Bool = false, cornerRadius: CGFloat = 0) { // configure init
        self.init()
        backgroundColor = color
        isUserInteractionEnabled = isUserInteraction
        layer.cornerRadius = cornerRadius
    }
    
    func transformToSection(name: String, iconName: String) {
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        layer.cornerRadius = 16
        clipsToBounds = true
        backgroundColor = ThemeColor.contrast
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = name
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            label.textColor = ThemeColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let iconView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "\(iconName)"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.opacity = 0.3
            imageView.tintColor = .gray
            return imageView
        }()
        
        let chevron: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.tintColor = ThemeColor.white
            return imageView
        }()
        
        let hStack: UIStackView = {
            let stack = UIStackView()
            stack.addArrangedSubview(nameLabel)
            stack.addArrangedSubview(chevron)
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()

        addSubview(iconView)
        addSubview(hStack)
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -16),
            iconView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 16),
            
            hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            hStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            hStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
}
