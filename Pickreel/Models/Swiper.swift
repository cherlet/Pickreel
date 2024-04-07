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
