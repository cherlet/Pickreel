import UIKit

class ReView: UIScrollView {
    // MARK: Properties
    private var cast: [Actor] = []
    
    // MARK: UI Elements
    private lazy var nameLabel = UILabel(textColor: ThemeColor.oppColor, font: UIFont.systemFont(ofSize: 24, weight: .semibold), numberOfLines: 0, alignment: .center)
    private lazy var yearHeadline = UILabel(headline: "Год")
    private lazy var yearContent = UILabel(textColor: ThemeColor.oppColor)
    private lazy var ratingHeadline = UILabel(headline: "Рейтинг")
    private lazy var ratingContent = UILabel(textColor: ThemeColor.oppColor)
    private lazy var genresHeadline = UILabel(headline: "Жанр")
    private lazy var genresContent = UILabel(textColor: ThemeColor.oppColor)
    private lazy var countriesHeadline = UILabel(headline: "Страна")
    private lazy var countriesContent = UILabel(textColor: ThemeColor.oppColor)
    private lazy var companiesHeadline = UILabel(headline: "Компания")
    private lazy var companiesContent = UILabel(textColor: ThemeColor.oppColor)
    private lazy var directorHeadline = UILabel(headline: "Режиссер")
    private lazy var directorContent = UILabel(textColor: ThemeColor.oppColor)
    private lazy var runtimeHeadline = UILabel(headline: "Время")
    private lazy var runtimeContent = UILabel(textColor: ThemeColor.oppColor)
    private lazy var overviewHeadline = UILabel(headline: "Описание")
    private lazy var overviewContent = UILabel(textColor: ThemeColor.oppColor, numberOfLines: 0)
    private lazy var castHeadline = UILabel(headline: "Актеры")
    
    private lazy var castCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = ThemeColor.contrastColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: CastCell.identifier)
        return collectionView
    }()
    
    // MARK: Initialize
    init(media: Media) {
        super.init(frame: .zero)
        self.setup(with: media)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup(with media: Media) {
        layer.cornerRadius = 16
        backgroundColor = ThemeColor.contrastColor
        showsVerticalScrollIndicator = false
        
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        
        let mid = (media.credits.cast.count / 2) - 1
        
        cast = media.credits.cast
        DispatchQueue.main.async {
            self.castCollectionView.reloadData()
        }
        
        nameLabel.text = media.title.ru
        yearContent.text = String(media.year)
        ratingContent.text = String(media.rating.imdb)
        genresContent.text = media.genres.ru.toString()
        countriesContent.text = media.countries.ru.toString()
        companiesContent.text = media.companies.toString()
        overviewContent.text = media.overview.ru
        
        let hours = media.runtime / 60
        let minutes = media.runtime - 60 * hours
        runtimeContent.text = "\(hours) ч. \(minutes) мин."
        
        var directors: [String] = []
        for person in media.credits.crew {
            guard directors.count <= 5 else { break }
            if person.jobEn == "director" { directors.append(person.nameRu) }
        }
        
        directorContent.text = directors.toString()
        
        setupLayout()
    }
    
    private func setupLayout() {
        let yearStack = UIStackView(arrangedSubviews: [yearHeadline, yearContent])
        let ratingStack = UIStackView(arrangedSubviews: [ratingHeadline, ratingContent])
        let genresStack = UIStackView(arrangedSubviews: [genresHeadline, genresContent])
        let countriesStack = UIStackView(arrangedSubviews: [countriesHeadline, countriesContent])
        let companiesStack = UIStackView(arrangedSubviews: [companiesHeadline, companiesContent])
        let directorStack = UIStackView(arrangedSubviews: [directorHeadline, directorContent])
        let runtimeStack = UIStackView(arrangedSubviews: [runtimeHeadline, runtimeContent])
        
        [yearStack, ratingStack, genresStack, countriesStack, companiesStack, directorStack, runtimeStack].forEach {
            $0.axis = .horizontal
            $0.spacing = 8
        }
        
        let infoStack = UIStackView(arrangedSubviews: [yearStack, ratingStack, genresStack, countriesStack, companiesStack, directorStack, runtimeStack])
        infoStack.axis = .vertical
        infoStack.spacing = 16
        
        [nameLabel, infoStack, overviewHeadline, overviewContent, castHeadline, castCollectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            infoStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            infoStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            infoStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            overviewHeadline.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: 16),
            overviewHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            overviewContent.topAnchor.constraint(equalTo: overviewHeadline.bottomAnchor, constant: 8),
            overviewContent.leadingAnchor.constraint(equalTo: overviewHeadline.leadingAnchor),
            overviewContent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            castHeadline.topAnchor.constraint(equalTo: overviewContent.bottomAnchor, constant: 16),
            castHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            castCollectionView.topAnchor.constraint(equalTo: castHeadline.bottomAnchor, constant: 8),
            castCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            castCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            castCollectionView.heightAnchor.constraint(equalToConstant: 88),
            castCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
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
