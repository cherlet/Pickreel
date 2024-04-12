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
    
    convenience init(iconName: String = "circle", iconColor: UIColor? = .clear, isCustom: Bool = false, isHidden: Bool = false) { // icon init
        self.init()
        
        if isCustom {
            self.image = UIImage(named: iconName)
        } else {
            self.image = UIImage(systemName: iconName) 
        }
        
        self.tintColor = iconColor
        self.isHidden = isHidden
    }
    
    convenience init(clipsToBounds: Bool = false, contentMode: UIView.ContentMode = .scaleToFill, cornerRadius: CGFloat = 0) { // configure init
        self.init()
        self.clipsToBounds = clipsToBounds
        self.contentMode = contentMode
        self.layer.cornerRadius = cornerRadius
    }
    
    func setGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.5).cgColor]
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
