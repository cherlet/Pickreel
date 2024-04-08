import UIKit

class ReView: UIView {
    // MARK: Properties
    private var cast: [Actor] = []
    private var crew: [Person] = []
    private var genres: Genres = Genres(ru: [], en: [])
    
    // MARK: UI Elements
    private lazy var nameLabel = UILabel(fontSize: 30, fontWeight: .bold, numberOfLines: 0, alignment: .center)
    private lazy var ratingLabel = UILabel(fontSize: 14, fontWeight: .semibold)
    private lazy var votesLabel = UILabel(textColor: ThemeColor.silent, fontSize: 14)
    private lazy var infoLabel = UILabel(textColor: ThemeColor.silent, fontSize: 14)
    private lazy var productionLabel = UILabel(textColor: ThemeColor.silent, fontSize: 14)
    private lazy var genreHeadline = UILabel(text: "Жанры", textColor: ThemeColor.white,  fontSize: 16)
    private lazy var overviewHeadline = UILabel(text: "Описание", textColor: ThemeColor.white,  fontSize: 16)
    private lazy var castHeadline = UILabel(text: "В главных ролях", textColor: ThemeColor.white,  fontSize: 16)
    private lazy var crewHeadline = UILabel(text: "Съемочная группа", textColor: ThemeColor.white,  fontSize: 16)
    
    private lazy var castCollectionView = UICollectionView.getPersonCollection(identifier: PersonCell.castIdentifier, tag: 0)
    private lazy var crewCollectionView = UICollectionView.getPersonCollection(identifier: PersonCell.crewIdentifier, tag: 1)
    private lazy var genreCollectionView = UICollectionView.getGenreCollection(tag: 2)
    
    private lazy var swipeImage = UIImageView(clipsToBounds: true, cornerRadius: 16)
    
    // MARK: Initialize
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup() {
        layer.cornerRadius = 16
        backgroundColor = ThemeColor.contrast
        
        [castCollectionView, crewCollectionView, genreCollectionView].forEach {
            $0.delegate = self
            $0.dataSource = self
        }
        
        setupLayout()
    }
    
    private func setupLayout() {
        let ratingStack = UIStackView(arrangedSubviews: [ratingLabel, votesLabel])
        ratingStack.axis = .horizontal
        ratingStack.spacing = 4
        
        let infoStack = UIStackView(arrangedSubviews: [ratingStack, infoLabel, productionLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 4
        infoStack.alignment = .center
        
        [swipeImage, nameLabel, infoStack, genreHeadline, genreCollectionView, overviewHeadline, castHeadline, castCollectionView, crewHeadline, crewCollectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            swipeImage.topAnchor.constraint(equalTo: topAnchor),
            swipeImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            swipeImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            swipeImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            infoStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            infoStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            genreHeadline.topAnchor.constraint(equalTo: productionLabel.bottomAnchor, constant: 16),
            genreHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            genreCollectionView.topAnchor.constraint(equalTo: genreHeadline.bottomAnchor, constant: 16),
            genreCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            genreCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            genreCollectionView.heightAnchor.constraint(equalToConstant: 32),
            
            overviewHeadline.topAnchor.constraint(equalTo: genreCollectionView.bottomAnchor, constant: 16),
            overviewHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            castHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            castHeadline.bottomAnchor.constraint(equalTo: castCollectionView.topAnchor, constant: -16),
            
            castCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            castCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            castCollectionView.bottomAnchor.constraint(equalTo: crewHeadline.topAnchor, constant: -16),
            castCollectionView.heightAnchor.constraint(equalToConstant: 80),
            
            crewHeadline.bottomAnchor.constraint(equalTo: crewCollectionView.topAnchor, constant: -16),
            crewHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            crewCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            crewCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            crewCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            crewCollectionView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
}

// MARK: - Public Methods
extension ReView {
    func update(with media: Media) {
        // POSTER
        if let posterURL = media.posterURL, let url = URL(string: posterURL) {
            swipeImage.load(url: url)
        } else {
            // TODO: - Add image placeholder
        }
        
        // NAME
        nameLabel.text = media.title.ru
        
        // RATING LINE
        ratingLabel.setup(as: .rating, text: String(media.rating.imdb))
        let votes = Int(media.votes.imdb)
        votesLabel.text = votes >= 1000 ? "\(votes / 1000)К" : String(votes)
        
        // INFO LINE (adjusts to the type of content)
        var info = String()
        var seasons = media.seasons ?? []
        if let firstSeason = seasons.first {
            if firstSeason.number == 0 {
                seasons.removeFirst()
            }
        }
        
        if let releaseYear = seasons.first?.date?.prefix(4) {
            if let finalYear = seasons.last?.date?.prefix(4) {
                info += "\(releaseYear) - \(finalYear)"
            } else {
                info += "\(releaseYear) - ..."
            }
        } else {
            info += "\(media.year)"
        }
        
        if media.runtime != 0 {
            if media.runtime >= 60 {
                let hours = media.runtime / 60
                let minutes = media.runtime - 60 * hours
                
                if minutes == 0 {
                    info += ", \(hours) ч."
                } else {
                    info += ", \(hours) ч. \(minutes) мин."
                }
            } else {
                info += ", \(media.runtime) мин."
            }
        }
        
        if let ageRating = media.ageRating {
            info += ", \(ageRating)+"
        }
        
        infoLabel.text = info
        
        // PRODUCTION LINE
        var production = String()
        
        if let country = media.countries.ru.first {
            production += "\(country)"
        }
        
        if let company = media.companies.first, company.count < 25 {
            production += ", \(company)"
        }
        
        productionLabel.text = production
        
        // CAST & CREW & GENRES
        cast = media.credits.cast
        crew = media.credits.crew
        genres = media.genres
        
        if let index = crew.firstIndex(where: { $0.jobEn == "director"}) {
            let director = crew[index]
            crew.remove(at: index)
            crew.insert(director, at: 0)
        }
        
        if let index = crew.firstIndex(where: { $0.jobEn == "writer"}) {
            let writer = crew[index]
            crew.remove(at: index)
            crew.insert(writer, at: 1)
        }
        
        if let index = crew.firstIndex(where: { $0.jobEn == "producer"}) {
            let producer = crew[index]
            crew.remove(at: index)
            crew.insert(producer, at: 2)
        }
        
        DispatchQueue.main.async {
            self.castCollectionView.reloadData()
            self.crewCollectionView.reloadData()
            self.genreCollectionView.reloadData()
        }
    }
    
    func setEffects() {
        swipeImage.setBlur()
        swipeImage.transform = CGAffineTransformMakeScale(-1, 1)
    }
}

// MARK: - CastCollectionView DataSource/Delegate
extension ReView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return cast.count
        } else if collectionView.tag == 1 {
            return crew.count
        } else {
            return genres.ru.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0  {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCell.castIdentifier, for: indexPath) as? PersonCell else {
                fatalError("DEBUG: Failed with custom cell bug")
            }
            
            let actor = cast[indexPath.row]
            cell.configure(name: actor.nameRu, role: actor.character, posterURL: actor.posterURL)
            return cell
        } else if collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCell.crewIdentifier, for: indexPath) as? PersonCell else {
                fatalError("DEBUG: Failed with custom cell bug")
            }
            
            let person = crew[indexPath.row]
            let job = person.jobEn.prefix(1).uppercased() + person.jobEn.dropFirst()
            cell.configure(name: person.nameRu, role: job, posterURL: person.posterURL)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell else {
                fatalError("DEBUG: Failed with custom cell bug")
            }
            
            let genre = genres.ru[indexPath.row]
            cell.configure(genre: genre)
            return cell
        }
    }
}
