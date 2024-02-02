import Foundation

struct Content {
    var name: String
    var year: Int
    var rating: Double
    var countries: [String]
    var genres: [String]
    var poster: String
}

extension Content {
    func isAllowed(filter: Filter) -> Bool {
        guard year >= filter.years.left && year <= filter.years.right else { return false }
        guard rating >= filter.ratings.left && rating <= filter.ratings.right else { return false }
        return true
    }
}
