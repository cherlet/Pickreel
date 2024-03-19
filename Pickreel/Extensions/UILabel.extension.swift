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
}
