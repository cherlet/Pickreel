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
    
    convenience init(iconName: String, color: UIColor) {
        self.init()
        self.image = UIImage(systemName: iconName)
        self.tintColor = color
    }
}
