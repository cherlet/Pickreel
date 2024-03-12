import UIKit

struct ThemeColor {
    static let generalColor = UIColor.appColor(CustomColor.GeneralColor)
    static let backgroundColor = UIColor.appColor(CustomColor.BackgroundColor)
    static let silentColor = UIColor.appColor(CustomColor.SilentColor)
    static let contrastColor = UIColor.appColor(CustomColor.ContrastColor)
    static let oppColor = UIColor.appColor(CustomColor.OppColor)
    static let greenGradientFirst = UIColor.appColor(CustomColor.GreenGradientFirstColor)
    static let greenGradientSecond = UIColor.appColor(CustomColor.GreenGradientSecondColor)
    static let redGradientFirst = UIColor.appColor(CustomColor.RedGradientFirstColor)
    static let redGradientSecond = UIColor.appColor(CustomColor.RedGradientSecondColor)
    static let yellowGradientFirst = UIColor.appColor(CustomColor.YellowGradientFirstColor)
    static let yellowGradientSecond = UIColor.appColor(CustomColor.YellowGradientSecondColor)
    static let tableFrontColor = UIColor.appColor(CustomColor.TableFrontColor)
    static let tableBackColor = UIColor.appColor(CustomColor.TableBackColor)
}

enum CustomColor: String {
    case GeneralColor
    case BackgroundColor
    case SilentColor
    case ContrastColor
    case OppColor
    case GreenGradientFirstColor
    case GreenGradientSecondColor
    case RedGradientFirstColor
    case RedGradientSecondColor
    case YellowGradientFirstColor
    case YellowGradientSecondColor
    case TableFrontColor
    case TableBackColor
}
