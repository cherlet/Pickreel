import Foundation

// MARK: - Films
struct Films: Codable {
    let total, totalPages: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let kinopoiskID: Int
    let imdbID: String?
    let nameRu: String
    let nameEn: String?
    let nameOriginal: String?
    let countries: [Country]
    let genres: [Genre]
    let ratingKinopoisk, ratingImdb: Double?
    let year: Int?
    let type: TypeEnum
    let posterURL, posterURLPreview: String?

    enum CodingKeys: String, CodingKey {
        case kinopoiskID = "kinopoiskId"
        case imdbID = "imdbId"
        case nameRu, nameEn, nameOriginal, countries, genres, ratingKinopoisk, ratingImdb, year, type
        case posterURL = "posterUrl"
        case posterURLPreview = "posterUrlPreview"
    }
}

// MARK: - Country
struct Country: Codable {
    let country: String
}

// MARK: - Genre
struct Genre: Codable {
    let genre: String
}

enum TypeEnum: String, Codable {
    case film = "FILM"
    case tvSeries = "TV_SERIES"
}
