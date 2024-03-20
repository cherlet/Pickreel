import UIKit

protocol GeneralViewProtocol: AnyObject {
    func show(category: DataType, card: Card)
}

class GeneralViewController: UIViewController {
    var presenter: GeneralPresenterProtocol?
    
    // MARK: UI Elements
    private let moviesCategoryLabel = UILabel()
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
    func show(category: DataType, card: Card) {
        switch category {
        case .movies:
            DispatchQueue.main.async {
                self.moviesCategoryLabel.enable()
                self.seriesCategoryLabel.disable()
                let content = card.movie
                self.updateSwipeView(title: content.title.ru, year: String(content.year), rating: String(content.rating.imdb), posterURL: content.posterURL)
            }
        case .series:
            DispatchQueue.main.async {
                self.seriesCategoryLabel.enable()
                self.moviesCategoryLabel.disable()
                let content = card.series
                self.updateSwipeView(title: content.title.ru, year: String(content.year), rating: String(content.rating.imdb), posterURL: content.posterURL)
            }
        }
    }
}

// MARK: Setup
private extension GeneralViewController {
    func initialize() {
        view.backgroundColor = ThemeColor.backgroundColor
        setupSwipeView()
        setupCategories()
        setupFilters()
        setupLayout()
    }
    
    func setupLayout() {
        let uiElements = [moviesCategoryLabel, seriesCategoryLabel, filtersButton, swipeView]
        
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
            
            moviesCategoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            moviesCategoryLabel.bottomAnchor.constraint(equalTo: swipeView.topAnchor, constant: -20),
            
            seriesCategoryLabel.leadingAnchor.constraint(equalTo: moviesCategoryLabel.trailingAnchor, constant: 16),
            seriesCategoryLabel.centerYAnchor.constraint(equalTo: moviesCategoryLabel.centerYAnchor),
            
            filtersButton.widthAnchor.constraint(equalToConstant: 24),
            filtersButton.heightAnchor.constraint(equalToConstant: 24),
            filtersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filtersButton.centerYAnchor.constraint(equalTo: moviesCategoryLabel.centerYAnchor)
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
        moviesCategoryLabel.text = "Фильмы"
        moviesCategoryLabel.textColor = ThemeColor.generalColor
        moviesCategoryLabel.font = UIFont.systemFont(ofSize: 20)
        moviesCategoryLabel.isUserInteractionEnabled = true
        let moviesTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCategory))
        moviesCategoryLabel.addGestureRecognizer(moviesTapGestureRecognizer)
        
        seriesCategoryLabel.text = "Сериалы"
        seriesCategoryLabel.textColor = ThemeColor.silentColor
        seriesCategoryLabel.font = UIFont.systemFont(ofSize: 20)
        seriesCategoryLabel.isUserInteractionEnabled = true
        let seriesTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCategory))
        seriesCategoryLabel.addGestureRecognizer(seriesTapGestureRecognizer)
    }
    
    func setupFilters() {
        filtersButton.tintColor = ThemeColor.oppColor
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        let image = UIImage(systemName: "slider.horizontal.3", withConfiguration: config)
        filtersButton.setImage(image, for: .normal)
        filtersButton.addTarget(self, action: #selector(handleFilters), for: .touchUpInside)
    }
    
    func setupSwipeView() {
        name.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        name.numberOfLines = 0
        year.font = UIFont.systemFont(ofSize: 20)
        rating.font = UIFont.systemFont(ofSize: 20)
        
        [name, year, rating].forEach {
            $0.textColor = .white
        }
        
        swipeView.layer.cornerRadius = 16
        swipeImage.layer.cornerRadius = 16
        swipeImage.clipsToBounds = true
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeLeftGesture.direction = .left
        swipeView.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeRightGesture.direction = .right
        swipeView.addGestureRecognizer(swipeRightGesture)
    }
    
    func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.withAlphaComponent(0.5).cgColor]
        gradient.cornerRadius = 16
        gradient.frame = swipeImage.bounds
        swipeImage.layer.sublayers?.removeAll()
        swipeImage.layer.addSublayer(gradient)
    }
    
    // MARK: Actions
    @objc private func handleCategory() {
        presenter?.handleCategory()
    }
    
    @objc private func handleFilters() {
        presenter?.handleFilters()
    }
    
    @objc func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        switch gestureRecognizer.direction {
        case .left:
            presenter?.handleSwipe(direction: .left)
        case .right:
            presenter?.handleSwipe(direction: .right)
        default:
            break
        }
    }
}

// MARK: - Support Methods
private extension GeneralViewController {
    func updateSwipeView(title: String, year: String, rating: String, posterURL: String?) {
        name.text = title
        self.year.text = year
        self.rating.text = rating
        
        if let url = URL(string: posterURL ?? "") {
            swipeImage.load(url: url)
        } else {
            // TODO: - Add image placeholder
        }
    }
}


// MARK: - SwipeDirection Enum
enum SwipeDirection {
    case left
    case right
}
