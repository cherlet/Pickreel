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
