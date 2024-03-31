import UIKit

protocol GeneralViewProtocol: AnyObject {
    func show(category: MediaType, card: Card)
}

class GeneralViewController: UIViewController {
    var presenter: GeneralPresenterProtocol?
    
    // MARK: UI Elements
    private let moviesCategoryLabel = UILabel()
    private let seriesCategoryLabel = UILabel()
    private let filtersButton = UIButton()
    private let swipeView = SwipeView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewLoaded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        swipeView.setGradient()
    }
}

// MARK: Module
extension GeneralViewController: GeneralViewProtocol {
    func show(category: MediaType, card: Card) {
        switch category {
        case .movies:
            DispatchQueue.main.async {
                self.moviesCategoryLabel.enable()
                self.seriesCategoryLabel.disable()
                self.swipeView.update(with: card.movie)
            }
        case .series:
            DispatchQueue.main.async {
                self.seriesCategoryLabel.enable()
                self.moviesCategoryLabel.disable()
                self.swipeView.update(with: card.series)
            }
        }
    }
}

// MARK: Setup
private extension GeneralViewController {
    func initialize() {
        view.backgroundColor = ThemeColor.backgroundColor
        setupCategories()
        setupFilters()
        setupSwipeGestures()
        setupLayout()
    }
    
    func setupLayout() {
        [moviesCategoryLabel, seriesCategoryLabel, filtersButton, swipeView].forEach {
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
    
    func setupSwipeGestures() {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeLeftGesture.direction = .left
        swipeView.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeRightGesture.direction = .right
        swipeView.addGestureRecognizer(swipeRightGesture)
    }
}

// MARK: - Actions
private extension GeneralViewController {
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

// MARK: - SwipeDirection Enum
enum SwipeDirection {
    case left
    case right
}
