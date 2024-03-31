import UIKit

extension UILabel {
    func enable() {
        textColor = ThemeColor.generalColor
        isUserInteractionEnabled = false
    }
    
    func disable() {
        textColor = ThemeColor.silentColor
        isUserInteractionEnabled = true
    }
    
    convenience init(text: String = "", textColor: UIColor?, font: UIFont = UIFont.systemFont(ofSize: 16), numberOfLines: Int = 1, alignment: NSTextAlignment = .left) { // configured INIT
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
    }
    
    convenience init(headline: String) { // Headline INIT
        self.init()
        self.text = headline
        self.textColor = ThemeColor.generalColor
        self.font = UIFont.systemFont(ofSize: 16)
        self.numberOfLines = 0
    }
}
