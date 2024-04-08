import UIKit

struct Genres: Codable {
    var ru: [String]
    var en: [String]
}

extension Genres {
    static let all = Genres(ru: ["комедия", "боевик", "фэнтези", "детектив",  "драма", "семейный", "приключения", "мультфильм", "ужасы", "фантастика", "криминал", "военный"], 
                            en: ["Comedy", "Action", "Fantasy", "Mystery", "Drama", "Family", "Adventure", "Animation", "Horror", "Science Fiction", "Crime", "War"])
    
    static func findIndex(of genre: String?) -> Int? {
        guard let genre = genre else { return nil }
        
        if let index = Genres.all.ru.firstIndex(of: genre) {
            return index
        } else if let index = Genres.all.en.firstIndex(of: genre) {
            return index
        } else {
            return nil
        }
    }
    
    static func getAssociations(of genre: String) -> (color: UIColor?, icon: UIImage?)? {
        guard let index = findIndex(of: genre) else { return nil }
        
        switch index {
        case 0:
            return Association.comedy.info
        case 1:
            return Association.action.info
        case 2:
            return Association.fantasy.info
        case 3:
            return Association.mystery.info
        case 4:
            return Association.drama.info
        case 5:
            return Association.family.info
        case 6:
            return Association.adventure.info
        case 7:
            return Association.animation.info
        case 8:
            return Association.horror.info
        case 9:
            return Association.scienceFiction.info
        case 10:
            return Association.crime.info
        case 11:
            return Association.war.info
        default:
            return nil
        }
    }
}

enum Association {
    case comedy
    case action
    case fantasy
    case mystery
    case drama
    case family
    case adventure
    case animation
    case horror
    case scienceFiction
    case crime
    case war
    
    var info: (color: UIColor?, icon: UIImage?) {
        switch self {
        case .comedy:
            return (ThemeColor.comedy, ThemeIcon.comedy)
        case .action:
            return (ThemeColor.action, ThemeIcon.action)
        case .fantasy:
            return (ThemeColor.fantasy, ThemeIcon.fantasy)
        case .mystery:
            return (ThemeColor.mystery, ThemeIcon.mystery)
        case .drama:
            return (ThemeColor.drama, ThemeIcon.drama)
        case .family:
            return (ThemeColor.family, ThemeIcon.family)
        case .adventure:
            return (ThemeColor.adventure,ThemeIcon.adventure)
        case .animation:
            return (ThemeColor.animation, ThemeIcon.animation)
        case .horror:
            return (ThemeColor.horror, ThemeIcon.horror)
        case .scienceFiction:
            return (ThemeColor.scienceFiction, ThemeIcon.scienceFiction)
        case .crime:
            return (ThemeColor.crime, ThemeIcon.crime)
        case .war:
            return (ThemeColor.war, ThemeIcon.war)
        }
    }
}
