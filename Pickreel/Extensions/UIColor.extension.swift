import UIKit

extension UIColor {
    static func appColor(_ name: CustomColor) -> UIColor! {
        return UIColor(named: name.rawValue)
    }
}
