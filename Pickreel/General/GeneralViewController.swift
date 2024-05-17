import UIKit

protocol GeneralViewProtocol: AnyObject {
    func show(category: MediaType, card: Card)
}

class GeneralViewController: UIViewController {
    // MARK: Properties
    var presenter: GeneralPresenterProtocol?
    private var isFlipped = false
    
    // MARK: UI Elements
    private lazy var swipeView = SwipeView()
    private lazy var reView = ReView()
    
    private lazy var cardContainer = UIView()
    
    private lazy var moviesCategoryLabel: UILabel = {
        let label = UILabel()
        label.setup(as: .category, text: "Фильмы", isEnabled: true)
        return label
    }()
    
    private lazy var seriesCategoryLabel: UILabel = {
        let label = UILabel()
        label.setup(as: .category, text: "Сериалы", isEnabled: false)
        return label
    }()
    
    private lazy var filtersButton: UIButton = {
        let button = UIButton()
        button.tintColor = ThemeColor.opp
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        let image = UIImage(systemName: "slider.horizontal.3", withConfiguration: config)
        button.setImage(image, for: .normal)
        return button
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewLoaded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        swipeView.setEffects()
        reView.setEffects()
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
                self.reView.update(with: card.movie)
            }
        case .series:
            DispatchQueue.main.async {
                self.moviesCategoryLabel.disable()
                self.seriesCategoryLabel.enable()
                self.swipeView.update(with: card.series)
                self.reView.update(with: card.series)
            }
        }
    }
}

// MARK: Setup
private extension GeneralViewController {
    func initialize() {
        view.backgroundColor = ThemeColor.background
        setupGestures()
        setupLayout()
    }
    
    func setupLayout() {
        [moviesCategoryLabel, seriesCategoryLabel, filtersButton, cardContainer].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            cardContainer.heightAnchor.constraint(equalToConstant: 600),
            cardContainer.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor),
            cardContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            cardContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            cardContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            moviesCategoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            moviesCategoryLabel.bottomAnchor.constraint(equalTo: cardContainer.topAnchor, constant: -20),
            
            seriesCategoryLabel.leadingAnchor.constraint(equalTo: moviesCategoryLabel.trailingAnchor, constant: 16),
            seriesCategoryLabel.centerYAnchor.constraint(equalTo: moviesCategoryLabel.centerYAnchor),
            
            filtersButton.widthAnchor.constraint(equalToConstant: 24),
            filtersButton.heightAnchor.constraint(equalToConstant: 24),
            filtersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filtersButton.centerYAnchor.constraint(equalTo: moviesCategoryLabel.centerYAnchor)
        ])
        
        [reView, swipeView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            cardContainer.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            swipeView.topAnchor.constraint(equalTo: cardContainer.topAnchor),
            swipeView.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor),
            swipeView.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor),
            swipeView.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor),
            
            reView.topAnchor.constraint(equalTo: cardContainer.topAnchor),
            reView.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor),
            reView.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor),
            reView.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor)
        ])
        
    }
    
    func setupGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeLeft.direction = .left
        swipeView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeRight.direction = .right
        swipeView.addGestureRecognizer(swipeRight)
        
        swipeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        reView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        moviesCategoryLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCategory)))
        seriesCategoryLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCategory)))
        
        filtersButton.addTarget(self, action: #selector(handleFilters), for: .touchUpInside)
    }
}

// MARK: - Actions
private extension GeneralViewController {
    @objc func handleCategory() {
        presenter?.handleCategory()
        closeReview()
    }
    
    @objc func handleFilters() {
        presenter?.handleFilters()
        closeReview()
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
    
    @objc func handleTap() {
        isFlipped.toggle()
        swipeView.isHidden = isFlipped
        UIView.transition(with: cardContainer, duration: 0.4, options: [.transitionFlipFromRight, .showHideTransitionViews], animations: nil, completion: nil)
    }
}

// MARK: - Private Methods
private extension GeneralViewController {
    func closeReview() {
        if isFlipped {
            isFlipped = false
            swipeView.isHidden = false
            UIView.transition(with: cardContainer, duration: 0.4, options: [.transitionFlipFromLeft, .showHideTransitionViews], animations: nil, completion: nil)
        }
    }
}
