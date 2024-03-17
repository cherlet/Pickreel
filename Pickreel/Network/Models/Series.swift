import Foundation

// MARK: - Main Model
struct Series: Codable {
    let externalID: ExternalID
    let title: Title
    let year: Int
    let ageRating: Int?
    let posterURL: String?
    let overview: Overview
    let rating: SeriesRating
    let votes: SeriesVotes
    let genres: Genres
    let countries: Countries
    let companies: [String]
    let seasons: [Season]
    let credits: Credits
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

// MARK: - Series Rating
struct SeriesRating: Codable {
    let imdb: Double
    let kp: Double
    let tmdb: Double
}

// MARK: - Series Votes
struct SeriesVotes: Codable {
    let imdb: Int
    let kp: Int
    let tmdb: Int
}
