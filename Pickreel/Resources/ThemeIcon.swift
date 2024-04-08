import UIKit

struct ThemeIcon {
    static let comedy = UIImage(named: CustomIcon.ComedyIcon.rawValue)
    static let action = UIImage(named: CustomIcon.ActionIcon.rawValue)
    static let fantasy = UIImage(named: CustomIcon.FantasyIcon.rawValue)
    static let mystery = UIImage(named: CustomIcon.MysteryIcon.rawValue)
    static let drama = UIImage(named: CustomIcon.DramaIcon.rawValue)
    static let family = UIImage(named: CustomIcon.FamilyIcon.rawValue)
    static let adventure = UIImage(named: CustomIcon.AdventureIcon.rawValue)
    static let animation = UIImage(named: CustomIcon.AnimationIcon.rawValue)
    static let horror = UIImage(named: CustomIcon.HorrorIcon.rawValue)
    static let scienceFiction = UIImage(named: CustomIcon.ScienceFictionIcon.rawValue)
    static let crime = UIImage(named: CustomIcon.CrimeIcon.rawValue)
    static let war = UIImage(named: CustomIcon.WarIcon.rawValue)
}

enum CustomIcon: String {
    case ComedyIcon
    case ActionIcon
    case FantasyIcon
    case MysteryIcon
    case DramaIcon
    case FamilyIcon
    case AdventureIcon
    case AnimationIcon
    case HorrorIcon
    case ScienceFictionIcon
    case CrimeIcon
    case WarIcon
}
