import UIKit

struct ThemeColor {
    static let generalColor = UIColor.appColor(CustomColor.GeneralColor)
    static let backgroundColor = UIColor.appColor(CustomColor.BackgroundColor)
    static let silentColor = UIColor.appColor(CustomColor.SilentColor)
    static let contrastColor = UIColor.appColor(CustomColor.ContrastColor)
}

enum CustomColor: String {
    case GeneralColor
    case BackgroundColor
    case SilentColor
    case ContrastColor
}

extension UIColor {
    static func appColor(_ name: CustomColor) -> UIColor! {
        return UIColor(named: name.rawValue)
    }
}
