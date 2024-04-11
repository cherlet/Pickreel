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
    static let comedy = UIColor.appColor(CustomColor.ComedyColor)
    static let action = UIColor.appColor(CustomColor.ActionColor)
    static let fantasy = UIColor.appColor(CustomColor.FantasyColor)
    static let mystery = UIColor.appColor(CustomColor.MysteryColor)
    static let drama = UIColor.appColor(CustomColor.DramaColor)
    static let family = UIColor.appColor(CustomColor.FamilyColor)
    static let adventure = UIColor.appColor(CustomColor.AdventureColor)
    static let animation = UIColor.appColor(CustomColor.AnimationColor)
    static let horror = UIColor.appColor(CustomColor.HorrorColor)
    static let scienceFiction = UIColor.appColor(CustomColor.ScienceFictionColor)
    static let crime = UIColor.appColor(CustomColor.CrimeColor)
    static let war = UIColor.appColor(CustomColor.WarColor)
    static let black = UIColor.appColor(CustomColor.BlackColor)
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
    case ComedyColor
    case ActionColor
    case FantasyColor
    case MysteryColor
    case DramaColor
    case FamilyColor
    case AdventureColor
    case AnimationColor
    case HorrorColor
    case ScienceFictionColor
    case CrimeColor
    case WarColor
    case BlackColor
}
