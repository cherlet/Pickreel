import UIKit

class ReView: UIView {
    // MARK: Properties
    private var cast: [Actor] = []
    
    // MARK: UI Elements
    private lazy var nameLabel = UILabel(fontSize: 30, fontWeight: .bold, numberOfLines: 0, alignment: .center)
    private lazy var ratingLabel = UILabel(fontSize: 14, fontWeight: .semibold)
    private lazy var votesLabel = UILabel(textColor: ThemeColor.silent, fontSize: 14)
    private lazy var infoLabel = UILabel(textColor: ThemeColor.silent, fontSize: 14)
    private lazy var productionLabel = UILabel(textColor: ThemeColor.silent, fontSize: 14)
    private lazy var overviewHeadline = UILabel(text: "Описание", textColor: ThemeColor.white,  fontSize: 16)
    private lazy var castHeadline = UILabel(text: "В главных ролях", textColor: ThemeColor.white,  fontSize: 16)
    private lazy var crewHeadline = UILabel(text: "Съемочная группа", textColor: ThemeColor.white,  fontSize: 16)
    
    private lazy var castCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: CastCell.identifier)
        return collectionView
    }()
    
    private lazy var swipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.transform = CGAffineTransformMakeScale(-1, 1)
        return imageView
    }()
    
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
        
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
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
        
        [swipeImage, nameLabel, infoStack, overviewHeadline, castHeadline, castCollectionView, crewHeadline].forEach {
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
            
            overviewHeadline.topAnchor.constraint(equalTo: productionLabel.bottomAnchor, constant: 16),
            overviewHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            castHeadline.topAnchor.constraint(equalTo: overviewHeadline.bottomAnchor, constant: 16),
            castHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            castCollectionView.topAnchor.constraint(equalTo: castHeadline.bottomAnchor, constant: 16),
            castCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            castCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            castCollectionView.heightAnchor.constraint(equalToConstant: 80),
            
            crewHeadline.topAnchor.constraint(equalTo: castCollectionView.bottomAnchor, constant: 16),
            crewHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }
}

// MARK: - Methods
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
        
        // CAST & CREW
        cast = media.credits.cast
        DispatchQueue.main.async {
            self.castCollectionView.reloadData()
        }
    }
    
    func setEffects() {
        swipeImage.setBlur()
    }
}

// MARK: - CastCollectionView DataSource/Delegate
extension ReView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.identifier, for: indexPath) as? CastCell else {
            fatalError("DEBUG: Failed with custom cell bug")
        }
        
        let actor = cast[indexPath.row]
        cell.configure(with: actor)
        return cell
    }
}
