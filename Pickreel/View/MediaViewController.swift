import UIKit

protocol MediaViewProtocol: AnyObject {
    func setup(with media: Media)
}

class MediaViewController: UIViewController {
    var presenter: MediaPresenterProtocol?
    private var isFlipped = false

    // MARK: UI Elements
    private lazy var swipeView = SwipeView(asFullscreen: true)
    private lazy var reView = ReView(asFullscreen: true)
    private lazy var cardContainer = UIView()
    

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        swipeView.setEffects()
        reView.setEffects()
    }
}

// MARK: Module 
extension MediaViewController: MediaViewProtocol {
    func setup(with media: Media) {
        swipeView.update(with: media)
        reView.update(with: media)
    }
}

// MARK: Setup
private extension MediaViewController {
    func initialize() {
        view.backgroundColor = ThemeColor.background
        setupGestures()
        setupLayout()
    }
    
    func setupLayout() {
        cardContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardContainer)
        
        NSLayoutConstraint.activate([
            cardContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cardContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cardContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
        swipeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        reView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
}

// MARK: - Actions
private extension MediaViewController {
    @objc func handleTap() {
        isFlipped.toggle()
        swipeView.isHidden = isFlipped
        UIView.transition(with: cardContainer, duration: 0.4, options: [.transitionFlipFromRight, .showHideTransitionViews], animations: nil, completion: nil)
    }
}

// MARK: - Public methods
extension MediaViewController {
    func closeReview() {
        if isFlipped {
            isFlipped = false
            swipeView.isHidden = false
            UIView.transition(with: cardContainer, duration: 0.4, options: [.transitionFlipFromLeft, .showHideTransitionViews], animations: nil, completion: nil)
        }
    }
}
