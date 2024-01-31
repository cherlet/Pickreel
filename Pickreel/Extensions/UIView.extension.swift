import UIKit

extension UIView {
    func transformToSection(name: String, iconName: String) {
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        layer.cornerRadius = 16
        clipsToBounds = true
        backgroundColor = ThemeColor.contrastColor
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = name
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            label.textColor = .white
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
            imageView.tintColor = .white
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
    
    // not worked :)
//    func setGradient(colors: (UIColor?, UIColor?)) {
//        let gradient = CAGradientLayer()
//        gradient.frame = self.bounds
//        gradient.colors = [colors.0 ?? .black.withAlphaComponent(0), colors.1 ?? .black.withAlphaComponent(0)]
//        gradient.startPoint = CGPoint(x: 0, y: 0.5)
//        gradient.endPoint = CGPoint(x: 1, y: 0.5)
//        gradient.locations = [0, 1]
//        gradient.cornerRadius = 16
//        self.layer.addSublayer(gradient)
//    }
}
