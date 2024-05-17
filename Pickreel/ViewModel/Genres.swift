import UIKit

let ALL_GENRES_RU = ["комедия", "боевик", "фэнтези", "детектив",  "драма", "семейный", "приключения", "мультфильм", "ужасы", "фантастика", "криминал", "военный"]
let ALL_GENRES_EN = ["Comedy", "Action", "Fantasy", "Mystery", "Drama", "Family", "Adventure", "Animation", "Horror", "Science Fiction", "Crime", "War"]

struct Genres: Codable {
    var ru: [String]
    var en: [String]
}

extension Genres {
    static let all = Genres(ru: ALL_GENRES_RU, en: ALL_GENRES_EN)
    
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
        
        return Association(rawValue: index)?.info
    }
}

enum Association: Int, CaseIterable {
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
