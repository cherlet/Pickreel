import UIKit

protocol FiltersViewProtocol: AnyObject {
}

class FiltersViewController: UIViewController {
    var presenter: FiltersPresenterProtocol?

    // MARK: UI Elements
    private let headerLabel = UILabel()
    private let countriesFilterLabel = UILabel()
    private let genresFilterLabel = UILabel()
    private let yearFilterLabel = UILabel()
    private let ratingFilterLabel = UILabel()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: Module 
extension FiltersViewController: FiltersViewProtocol {
}

// MARK: Setup
private extension FiltersViewController {
    func initialize() {
        view.backgroundColor = ThemeColor.backgroundColor
        setupSectionLabels()
        setupLayout()
    }
    
    func setupLayout() {
        let sectionLabels = [headerLabel, yearFilterLabel, ratingFilterLabel, countriesFilterLabel, genresFilterLabel]
        sectionLabels.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            yearFilterLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            yearFilterLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            
            ratingFilterLabel.topAnchor.constraint(equalTo: yearFilterLabel.bottomAnchor, constant: 16),
            ratingFilterLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            
            countriesFilterLabel.topAnchor.constraint(equalTo: ratingFilterLabel.bottomAnchor, constant: 16),
            countriesFilterLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            
            genresFilterLabel.topAnchor.constraint(equalTo: countriesFilterLabel.bottomAnchor, constant: 16),
            genresFilterLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
        ])
    }
    
    func setupSectionLabels() {
        headerLabel.text = "Фильтры"
        headerLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        headerLabel.textColor = ThemeColor.oppColor
        
        yearFilterLabel.text = "Год:"
        ratingFilterLabel.text = "Рейтинг:"
        countriesFilterLabel.text = "Страна:"
        genresFilterLabel.text = "Жанр:"
        
        [yearFilterLabel, ratingFilterLabel, countriesFilterLabel, genresFilterLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 20)
            $0.textColor = ThemeColor.contrastColor
        }
    }
}
