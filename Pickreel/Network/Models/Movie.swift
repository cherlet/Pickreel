import Foundation

// MARK: - Main Model
struct Movie: Codable {
    let externalID: ExternalID
    let title: Title
    let year: Int
    let runtime: Int
    let ageRating: Int?
    let posterURL: String?
    let overview: Overview
    let rating: Rating
    let votes: Votes
    let genres: Genres
    let countries: Countries
    let companies: [String]
    let credits: Credits
}

// MARK: - Credits
struct Credits: Codable {
    let cast: [Actor]
    let crew: [Person]
}

// MARK: - Actor
struct Actor: Codable {
    let nameRu: String
    let nameEn: String
    let character: String
    let posterURL: String?
}

// MARK: - Employee
struct Person: Codable {
    let nameRu: String
    let nameEn: String
    let jobRu: String
    let jobEn: String
    let posterURL: String?
}

// MARK: - External ID
struct ExternalID: Codable {
    let imdb: String
    let kp: Int
    let tmdb: Int
}

// MARK: - Title
struct Title: Codable {
    let ru: String
    let en: String
    let original: String
}

// MARK: - Country
struct Countries: Codable {
    let ru: [String]
    let en: [String]
}

// MARK: - Genre
struct Genres: Codable {
    let ru: [String]
    let en: [String]
}

// MARK: - Rating
struct Rating: Codable {
    let imdb: Double
    let kp: Double
    let tmdb: Double
    let filmCritics: Double
}

// MARK: - Overview
struct Overview: Codable {
    let ru: String
    let en: String
}

// MARK: - Votes
struct Votes: Codable {
    let imdb: Int
    let kp: Int
    let tmdb: Int
    let filmCritics: Int
}



// MARK: - Filter Extension
extension Movie {
    func isAllowed(filter: Filter) -> Bool {
        guard year >= filter.years.left && year <= filter.years.right else { return false }
        guard rating.imdb >= filter.ratings.left && rating.imdb <= filter.ratings.right else { return false }
        return true
    }
}

