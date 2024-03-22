import Foundation

class Page {
    // MARK: Variables
    var data: MediaData
    var currentCard: Card {
        getCard(dataStatus: data.getDataStatus())
    }
    
    // MARK: Initialize
    init(data: MediaData) {
        self.data = data
    }
}

// MARK: - Media
struct MediaData {
    var movies: [Media]
    var series: [Media]
    var swiper: Swiper
    
    init(movies: [Media], series: [Media]) {
        self.movies = movies
        self.series = series
        self.swiper = Swiper()
    }
    
    func getDataStatus() -> (movies: Bool, series: Bool) {
        var dataStatus: (movies: Bool, series: Bool)
        dataStatus.movies = swiper.movieIterator.value < movies.count
        dataStatus.series = swiper.seriesIterator.value < series.count
        return dataStatus
    }
}

// MARK: - Swiper
struct Swiper {
    var movieIterator = Iterator()
    var seriesIterator = Iterator()
    
    mutating func step(for type: MediaType) {
        switch type {
        case .movies:
            movieIterator.increase()
        case .series:
            seriesIterator.increase()
        }
    }
    
    mutating func reset(for type: MediaType) {
        switch type {
        case .movies:
            movieIterator.reset()
        case .series:
            seriesIterator.reset()
        }
    }
}

// MARK: - Card
struct Card {
    let movie: Media
    let series: Media
}

// MARK: - GetCard
extension Page {
    private func getCard(dataStatus: (movies: Bool, series: Bool)) -> Card {
        let externalID = ExternalID(imdb: "", kp: 0, tmdb: 0)
        let title = Title(ru: "Данные отсутствуют", en: "Out of data", original: "Out of data")
        let posterURL = "https://i.imgur.com/ob2h2BA.png"
        let overview = Overview(ru: "", en: "")
        let rating = Rating(pr: 0, imdb: 0, kp: 0, tmdb: 0, filmCritics: 0)
        let genres = Genres(ru: [], en: [])
        let countries = Countries(ru: [], en: [])
        let credits = Credits(cast: [], crew: [])
        
        let placeholder = Media(externalID: externalID, isMovie: true, title: title, year: 0, runtime: 0, ageRating: 0, posterURL: posterURL, overview: overview, rating: rating, votes: rating, genres: genres, countries: countries, companies: [], seasons: [], credits: credits)
        
        if dataStatus.movies == true, dataStatus.series == true {
            return Card(movie: data.movies[data.swiper.movieIterator.value], series: data.series[data.swiper.seriesIterator.value])
        } else if dataStatus.movies == false, dataStatus.series == true {
            return Card(movie: placeholder, series: data.series[data.swiper.seriesIterator.value])
        } else if dataStatus.movies == true, dataStatus.series == false {
            return Card(movie: data.movies[data.swiper.movieIterator.value], series: placeholder)
        } else {
            return Card(movie: placeholder, series: placeholder)
        }
    }
}
