import UIKit

protocol GeneralViewProtocol: AnyObject {
    func show(film: Content)
    func show(series: Content)
}

class GeneralViewController: UIViewController {
    var presenter: GeneralPresenterProtocol?
    
    // MARK: UI Elements
    private let filmCategoryLabel = UILabel()
    private let seriesCategoryLabel = UILabel()
    private let filtersButton = UIButton()
    
    private let swipeView = UIView()
    private let swipeImage = UIImageView()
    private let name = UILabel()
    private let year = UILabel()
    private let rating = UILabel()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewLoaded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupGradient()
    }
}

// MARK: Module
extension GeneralViewController: GeneralViewProtocol {
    func show(film: Content) {
        filmCategoryLabel.textColor = ThemeColor.generalColor
        seriesCategoryLabel.textColor = ThemeColor.silentColor
        
        setupSwipeView(content: film)
    }
    
    func show(series: Content) {
        seriesCategoryLabel.textColor = ThemeColor.generalColor
        filmCategoryLabel.textColor = ThemeColor.silentColor
        
        setupSwipeView(content: series)
    }
}

// MARK: Setup
private extension GeneralViewController {
    func initialize() {
        view.backgroundColor = ThemeColor.backgroundColor
        setupLayout()
        setupCategories()
        setupFilters()
    }
    
    func setupLayout() {
        let uiElements = [filmCategoryLabel, seriesCategoryLabel, filtersButton, swipeView]
        
        uiElements.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            swipeView.heightAnchor.constraint(equalToConstant: 600),
            swipeView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor),
            swipeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            swipeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            swipeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swipeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            filmCategoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filmCategoryLabel.bottomAnchor.constraint(equalTo: swipeView.topAnchor, constant: -20),
            
            seriesCategoryLabel.leadingAnchor.constraint(equalTo: filmCategoryLabel.trailingAnchor, constant: 16),
            seriesCategoryLabel.centerYAnchor.constraint(equalTo: filmCategoryLabel.centerYAnchor),
            
            filtersButton.widthAnchor.constraint(equalToConstant: 24),
            filtersButton.heightAnchor.constraint(equalToConstant: 24),
            filtersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filtersButton.centerYAnchor.constraint(equalTo: filmCategoryLabel.centerYAnchor)
        ])
        
        let ratingIcon = UIImageView(image: UIImage(systemName: "star.fill"))
        let yearIcon = UIImageView(image: UIImage(systemName: "calendar"))
        
        [ratingIcon, yearIcon].forEach {
            $0.tintColor = .white
        }
        
        let swipeElements = [swipeImage, name, year, rating, ratingIcon, yearIcon]
        
        swipeElements.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            swipeView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([ // building interface from bottom up
            ratingIcon.bottomAnchor.constraint(equalTo: swipeView.bottomAnchor, constant: -48),
            ratingIcon.leadingAnchor.constraint(equalTo: swipeView.leadingAnchor, constant: 16),
            
            rating.centerYAnchor.constraint(equalTo: ratingIcon.centerYAnchor),
            rating.leadingAnchor.constraint(equalTo: ratingIcon.trailingAnchor, constant: 8),
            
            yearIcon.bottomAnchor.constraint(equalTo: ratingIcon.topAnchor, constant: -16),
            yearIcon.leadingAnchor.constraint(equalTo: ratingIcon.leadingAnchor),
            
            year.centerYAnchor.constraint(equalTo: yearIcon.centerYAnchor),
            year.leadingAnchor.constraint(equalTo: yearIcon.trailingAnchor, constant: 8),
            
            name.bottomAnchor.constraint(equalTo: yearIcon.topAnchor, constant: -16),
            name.leadingAnchor.constraint(equalTo: swipeView.leadingAnchor, constant: 16),
            name.trailingAnchor.constraint(equalTo: swipeView.trailingAnchor, constant: -16),
            
            swipeImage.topAnchor.constraint(equalTo: swipeView.topAnchor),
            swipeImage.leadingAnchor.constraint(equalTo: swipeView.leadingAnchor),
            swipeImage.trailingAnchor.constraint(equalTo: swipeView.trailingAnchor),
            swipeImage.bottomAnchor.constraint(equalTo: swipeView.bottomAnchor)
        ])
    }
    
    func setupCategories() {
        filmCategoryLabel.text = "Фильмы"
        filmCategoryLabel.textColor = ThemeColor.generalColor
        filmCategoryLabel.font = UIFont.systemFont(ofSize: 20)
        filmCategoryLabel.isUserInteractionEnabled = true
        let filmTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapFilmCategory))
        filmCategoryLabel.addGestureRecognizer(filmTapGestureRecognizer)
        
        seriesCategoryLabel.text = "Сериалы"
        seriesCategoryLabel.textColor = ThemeColor.silentColor
        seriesCategoryLabel.font = UIFont.systemFont(ofSize: 20)
        seriesCategoryLabel.isUserInteractionEnabled = true
        let seriesTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSeriesCategory))
        seriesCategoryLabel.addGestureRecognizer(seriesTapGestureRecognizer)
    }
    
    func setupFilters() {
        filtersButton.tintColor = ThemeColor.oppColor
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        let image = UIImage(systemName: "slider.horizontal.3", withConfiguration: config)
        filtersButton.setImage(image, for: .normal)
        filtersButton.addTarget(self, action: #selector(didTapFiltersButton), for: .touchUpInside)
    }
    
    func setupSwipeView(content: Content) {
        name.text = content.name
        name.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        name.numberOfLines = 0
        
        year.text = String(content.year)
        year.font = UIFont.systemFont(ofSize: 20)
        
        rating.text = String(content.rating)
        rating.font = UIFont.systemFont(ofSize: 20)
        
        [name, year, rating].forEach {
            $0.textColor = .white
        }
        
        swipeView.layer.cornerRadius = 16
        
        swipeImage.layer.cornerRadius = 16
        swipeImage.clipsToBounds = true
        
        if let url = URL(string: content.poster) {
            swipeImage.load(url: url)
        } else {
            // placeholder
        }
    }
    
    func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.withAlphaComponent(0.5).cgColor]
        gradient.cornerRadius = 16
        gradient.frame = swipeImage.bounds
        swipeImage.layer.addSublayer(gradient)
    }
    
    // MARK: Actions
    @objc private func didTapFilmCategory() {
        presenter?.didTapFilmCategory()
    }
    
    @objc private func didTapSeriesCategory() {
        presenter?.didTapSeriesCategory()
    }
    
    @objc private func didTapFiltersButton() {
        presenter?.didTapFiltersButton()
    }
}
