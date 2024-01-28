protocol GeneralInteractorProtocol: AnyObject {
    func loadFilms()
    func loadSeries()
    func prepareContent()
}

class GeneralInteractor: GeneralInteractorProtocol {
    weak var presenter: GeneralPresenterProtocol?
    var iterator = 0
    var data: [Item] = [] {
        didSet {
            iterator = 0
        }
    }
    
    func loadFilms() {
        ApiManager.shared.getFilms { [weak self] films in
            self?.data = films
        }
    }
    
    func loadSeries() {
        ApiManager.shared.getSeries { [weak self] series in
            self?.data = series
        }
    }
    
    func prepareContent() {
        let current = data[iterator]
        let countries = current.countries.map { "\($0)" }
        let genres = current.genres.map { "\($0)"}
        
        let content = Content(name: current.nameRu,
                              year: current.year ?? 0,
                              rating: current.ratingKinopoisk ?? 0,
                              countries: countries,
                              genres: genres,
                              poster: current.posterURL ?? "")
        
        presenter?.setContent(content)
        iterator = iterator < data.count  ? 0 : iterator + 1
    }
}

struct Content {
    var name: String
    var year: Int
    var rating: Double
    var countries: [String]
    var genres: [String]
    var poster: String
}


