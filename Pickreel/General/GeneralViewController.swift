import UIKit

protocol GeneralViewProtocol: AnyObject {
}

class GeneralViewController: UIViewController {
    var presenter: GeneralPresenterProtocol?
    
    // MARK: UI Elements
    private var filmCategoryLabel = UILabel()
    private var tvCategoryLabel = UILabel()
    private var filtersButton = UIButton()
    
    private var swipeView = UIView()
    private var posterSectionIndicator = UIView()
    private var descriptionSectionIndicator = UIView()
    
    /*
    private var posterSectionIndicator = UIView()
    private var posterSectionView = UIView()
    private var posterSectionName = UILabel()
    private var posterSectionYear = UILabel()
    private var posterSectionRating = UILabel()
    private var posterSectionDuration = UILabel()
    private var posterSectionDirector = UILabel()
    
    private var descriptionSectionIndicator = UIView()
    private var descriptionSectionView = UIView()
    */
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

private extension GeneralViewController {
    func initialize() {
        view.backgroundColor = ThemeColor.backgroundColor
        setupCategories()
        setupFilters()
        setupSwipeView()
        setupLayout()
    }
    
    func setupLayout() {
        let uiElements = [filmCategoryLabel, tvCategoryLabel, filtersButton, swipeView]
        
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
            
            tvCategoryLabel.leadingAnchor.constraint(equalTo: filmCategoryLabel.trailingAnchor, constant: 16),
            tvCategoryLabel.centerYAnchor.constraint(equalTo: filmCategoryLabel.centerYAnchor),
            
            filtersButton.widthAnchor.constraint(equalToConstant: 24),
            filtersButton.heightAnchor.constraint(equalToConstant: 24),
            filtersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filtersButton.centerYAnchor.constraint(equalTo: filmCategoryLabel.centerYAnchor)
        ])
    }
    
    func setupCategories() {
        filmCategoryLabel.text = "Фильмы"
        filmCategoryLabel.textColor = ThemeColor.generalColor
        filmCategoryLabel.font = UIFont.systemFont(ofSize: 20)
        
        tvCategoryLabel.text = "Сериалы"
        tvCategoryLabel.textColor = ThemeColor.silentColor
        tvCategoryLabel.font = UIFont.systemFont(ofSize: 20)
    }
    
    func setupFilters() {
        filtersButton.tintColor = ThemeColor.oppColor
        filtersButton.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
    }
    
    func setupSwipeView() {
        swipeView.backgroundColor = ThemeColor.contrastColor?.withAlphaComponent(0.5)
        swipeView.layer.cornerRadius = 12
        
        posterSectionIndicator.backgroundColor = ThemeColor.oppColor
        posterSectionIndicator.layer.cornerRadius = 2
        
        descriptionSectionIndicator.backgroundColor = ThemeColor.contrastColor
        descriptionSectionIndicator.layer.cornerRadius = 2
    }
}

extension GeneralViewController: GeneralViewProtocol {
}
