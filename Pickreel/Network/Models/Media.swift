import Foundation

// MARK: - Main Model
struct Media: Codable {
    let externalID: ExternalID
    let isMovie: Bool
    let title: Title
    let year: Int
    let runtime: Int
    let ageRating: Int?
    let posterURL: String?
    let overview: Overview
    let rating: Rating
    let votes: Rating
    let genres: Genres
    let countries: Countries
    let companies: [String]
    let seasons: [Season]?
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

// MARK: - Rating
struct Rating: Codable {
    let pr: Double
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

// MARK: - Season
struct Season: Codable {
    let title: SeasonTitle
    let number: Int
    let episodeCount: Int
    let overview: Overview
    let date: String?
    let tmdbID: Int
    let tmdbRating: Double
}

// MARK: - Season Title
struct SeasonTitle: Codable {
    let ru: String
    let en: String
}
