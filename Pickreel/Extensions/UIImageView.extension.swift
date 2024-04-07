import UIKit

extension UIImageView {
    func load(url: URL, completion: (() -> Void)? = nil) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    convenience init(iconName: String, color: UIColor? = ThemeColor.white) {
        self.init()
        self.image = UIImage(systemName: iconName)
        self.tintColor = color
    }
    
    func setGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.withAlphaComponent(0.5).cgColor]
        gradient.cornerRadius = 16
        gradient.frame = self.bounds
        self.layer.sublayers?.removeAll()
        self.layer.addSublayer(gradient)
    }
    
    func setBlur() {
        let blur = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blur)
        view.frame = self.bounds
        self.subviews.forEach { $0.removeFromSuperview() }
        self.addSubview(view)
    }
}
