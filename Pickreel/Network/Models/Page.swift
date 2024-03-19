import Foundation

class Page {
    // MARK: Variables
    var data: Media
    var currentCard: Card {
        Card(movie: data.movies[swiper.movieIterator], series: data.series[swiper.seriesIterator])
    }
    var swiper: Swiper {
        willSet {
            if newValue.neededMovieBackup {
                Task {
                    await self.loadBackup(for: .movies)
                    self.swiper.reset(for: .movies)
                }
            } else if newValue.neededSeriesBackup {
                Task {
                    await self.loadBackup(for: .series)
                    self.swiper.reset(for: .series)
                }
            }
        }
    }
    
    // MARK: Initialize
    init(data: Media, swiper: Swiper = Swiper()) {
        self.data = data
        self.swiper = swiper
    }
    
    // MARK: Methods
    private func loadBackup(for type: DataType) async {
        switch type {
        case .movies:
            guard let backup = await NetworkManager.shared.loadData(of: type, limit: 10) as? [Movie] else { return }
            guard self.data.movies.count >= 20 else { return }
            self.data.movies.removeFirst(10)
            self.data.movies.append(contentsOf: backup)
        case .series:
            guard let backup = await NetworkManager.shared.loadData(of: type, limit: 10) as? [Series] else { return }
            guard self.data.series.count >= 20 else { return }
            self.data.series.removeFirst(10)
            self.data.series.append(contentsOf: backup)
        }
    }
}

// MARK: - Swiper
struct Swiper {
    var movieIterator = 0
    var seriesIterator = 0
    
    var neededMovieBackup = false
    var neededSeriesBackup = false
    
    mutating func step(for type: DataType) {
        switch type {
        case .movies:
            movieIterator += 1
            neededMovieBackup = movieIterator == 10 ? true : false
        case .series:
            seriesIterator += 1
            neededSeriesBackup = seriesIterator == 10 ? true : false
        }
    }
    
    mutating func reset(for type: DataType) {
        switch type {
        case .movies:
            movieIterator = 0
            neededMovieBackup = false
        case .series:
            seriesIterator = 0
            neededSeriesBackup = false
        }
    }
}

// MARK: - Card
struct Card {
    let movie: Movie
    let series: Series
}

// MARK: - Media
struct Media {
    var movies: [Movie]
    var series: [Series]
}
