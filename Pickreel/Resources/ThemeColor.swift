import UIKit

struct ThemeColor {
    static let general = UIColor.appColor(CustomColor.GeneralColor)
    static let background = UIColor.appColor(CustomColor.BackgroundColor)
    static let silent = UIColor.appColor(CustomColor.SilentColor)
    static let contrast = UIColor.appColor(CustomColor.ContrastColor)
    static let opp = UIColor.appColor(CustomColor.OppColor)
    static let tableFront = UIColor.appColor(CustomColor.TableFrontColor)
    static let tableBack = UIColor.appColor(CustomColor.TableBackColor)
    static let white = UIColor.appColor(CustomColor.WhiteColor)
    static let red = UIColor.appColor(CustomColor.RedColor)
    static let yellow = UIColor.appColor(CustomColor.YellowColor)
    static let green = UIColor.appColor(CustomColor.GreenColor)
    static let gray = UIColor.appColor(CustomColor.GrayColor)
}

enum CustomColor: String {
    case GeneralColor
    case BackgroundColor
    case SilentColor
    case ContrastColor
    case OppColor
    case TableFrontColor
    case TableBackColor
    case WhiteColor
    case RedColor
    case YellowColor
    case GreenColor
    case GrayColor
}
