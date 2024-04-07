import UIKit

extension UILabel {
    convenience init(text: String = "", textColor: UIColor? = ThemeColor.white, fontSize: CGFloat = 16, fontWeight: UIFont.Weight = .regular, numberOfLines: Int = 1, alignment: NSTextAlignment = .left) { // configured INIT
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
    }
    
    func enable() {
        textColor = ThemeColor.general
        isUserInteractionEnabled = false
    }
    
    func disable() {
        textColor = ThemeColor.silent
        isUserInteractionEnabled = true
    }
    
    func setup(as type: LabelType, text: String, isEnabled: Bool = false) {
        self.text = text
        
        switch type {
        case .category:
            textColor = isEnabled ? ThemeColor.general : ThemeColor.silent
            font = UIFont.systemFont(ofSize: 20)
            isUserInteractionEnabled = true
        case .rating:
            if let rating = Double(text) {
                if rating >= 8 {
                    textColor = ThemeColor.yellow
                } else if rating >= 7 {
                    textColor = ThemeColor.green
                } else {
                    textColor = ThemeColor.gray
                }
            }
        }
    }
}

// MARK: - LabelType Enum
extension UILabel {
    enum LabelType {
        case category
        case rating
    }
}
