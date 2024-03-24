import Foundation

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
}
