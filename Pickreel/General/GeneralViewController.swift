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
    private let posterSectionIndicator = UIView()
    private let descriptionSectionIndicator = UIView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        initialize()
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
        filtersButton.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
    }
    
    func setupSwipeView(content: Content) {
    }
    
    // MARK: Actions
    @objc private func didTapFilmCategory() {
        presenter?.didTapFilmCategory()
    }
    
    @objc private func didTapSeriesCategory() {
        presenter?.didTapSeriesCategory()
    }

}
