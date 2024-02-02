protocol GeneralInteractorProtocol: AnyObject {
    func loadFilms()
    func loadSeries()
}

class GeneralInteractor: GeneralInteractorProtocol {
    weak var presenter: GeneralPresenterProtocol?
    
    func loadFilms() {
        ApiManager.shared.getFilms { [weak self] films in
            var data: [Content] = []
            
            for film in films {
                let content = Content(name: film.nameRu,
                                      year: film.year ?? 0,
                                      rating: film.ratingKinopoisk ?? 0,
                                      countries: film.countries.map { "\($0)" },
                                      genres: film.genres.map { "\($0)"},
                                      poster: film.posterURL ?? "")
                data.append(content)
            }
            
            self?.presenter?.didLoad(films: data)
        }
    }
    
    func loadSeries() {
        ApiManager.shared.getSeries { [weak self] series in
            var data: [Content] = []
            
            for tv in series {
                let content = Content(name: tv.nameRu,
                                      year: tv.year ?? 0,
                                      rating: tv.ratingKinopoisk ?? 0,
                                      countries: tv.countries.map { "\($0)" },
                                      genres: tv.genres.map { "\($0)"},
                                      poster: tv.posterURL ?? "")
                data.append(content)
            }
            
            self?.presenter?.didLoad(series: data)
        }
    }
}


