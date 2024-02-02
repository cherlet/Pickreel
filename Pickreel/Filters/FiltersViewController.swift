import UIKit
import MultiSlider

protocol FiltersViewProtocol: AnyObject {
    func update(years: (Int, Int))
    func update(ratings: (Double, Double))
}

class FiltersViewController: UIViewController {
    var presenter: FiltersPresenterProtocol?

    // MARK: UI Elements
    private let headerLabel = UILabel()
    private let yearFilterLabel = UILabel()
    private let yearValueLabel = UILabel()
    private let yearSlider = MultiSlider()
    private let ratingFilterLabel = UILabel()
    private let ratingValueLabel = UILabel()
    private let ratingSlider = MultiSlider()
    private let countriesFilterLabel = UILabel()
    private let genresFilterLabel = UILabel()
    private let submitButton = UIButton()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        initialize()
    }
}

// MARK: Module 
extension FiltersViewController: FiltersViewProtocol {
    func update(years: (Int, Int)) {
        DispatchQueue.main.async {
            self.yearValueLabel.text = "\(years.0) - \(years.1)"
            self.yearSlider.value = [CGFloat(years.0), CGFloat(years.1)]
        }
    }
    
    func update(ratings: (Double, Double)) {
        DispatchQueue.main.async {
            self.ratingValueLabel.text = "\(ratings.0) - \(ratings.1)"
            self.ratingSlider.value = [CGFloat(ratings.0), CGFloat(ratings.1)]
        }
    }
}

// MARK: Setup
private extension FiltersViewController {
    func initialize() {
        view.backgroundColor = ThemeColor.backgroundColor
        setupSliders()
        setupSectionLabels()
        setupSubmitButton()
        setupLayout()
    }
    
    func setupLayout() {
        let yearStack = UIStackView(arrangedSubviews: [yearFilterLabel, yearValueLabel])
        let ratingStack = UIStackView(arrangedSubviews: [ratingFilterLabel, ratingValueLabel])
        
        [yearStack, ratingStack].forEach {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
        }
        
        let uiElements = [headerLabel, yearStack, yearSlider, ratingStack, ratingSlider, countriesFilterLabel, genresFilterLabel, submitButton]
        uiElements.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            yearStack.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            yearStack.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            yearStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            yearSlider.topAnchor.constraint(equalTo: yearStack.bottomAnchor, constant: 8),
            yearSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            yearSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            ratingStack.topAnchor.constraint(equalTo: yearSlider.bottomAnchor, constant: 16),
            ratingStack.leadingAnchor.constraint(equalTo: yearStack.leadingAnchor),
            ratingStack.trailingAnchor.constraint(equalTo: yearStack.trailingAnchor),
            
            ratingSlider.topAnchor.constraint(equalTo: ratingStack.bottomAnchor, constant: 8),
            ratingSlider.leadingAnchor.constraint(equalTo: yearSlider.leadingAnchor),
            ratingSlider.trailingAnchor.constraint(equalTo: yearSlider.trailingAnchor),
            
            countriesFilterLabel.topAnchor.constraint(equalTo: ratingSlider.bottomAnchor, constant: 16),
            countriesFilterLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            
            genresFilterLabel.topAnchor.constraint(equalTo: countriesFilterLabel.bottomAnchor, constant: 16),
            genresFilterLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            
            submitButton.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 40),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64),
            submitButton.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupSliders() {
        yearSlider.minimumValue = 1930
        yearSlider.maximumValue = 2030
        yearSlider.snapStepSize = 1
        yearSlider.outerTrackColor = ThemeColor.contrastColor
        yearSlider.orientation = .horizontal
        yearSlider.tintColor = ThemeColor.generalColor?.withAlphaComponent(0.5)
        yearSlider.thumbTintColor = .white
        yearSlider.hasRoundTrackEnds = true
        yearSlider.addTarget(self, action: #selector(yearSliderChanged), for: .valueChanged)
        
        ratingSlider.minimumValue = 0
        ratingSlider.maximumValue = 10
        yearSlider.snapStepSize = 0.1
        ratingSlider.outerTrackColor = ThemeColor.contrastColor
        ratingSlider.orientation = .horizontal
        ratingSlider.tintColor = ThemeColor.generalColor?.withAlphaComponent(0.5)
        ratingSlider.thumbTintColor = .white
        ratingSlider.addTarget(self, action: #selector(ratingSliderChanged), for: .valueChanged)
    }
    
    func setupSectionLabels() {
        headerLabel.text = "Фильтры"
        headerLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        headerLabel.textColor = ThemeColor.oppColor
        
        yearFilterLabel.text = "Год:"
        ratingFilterLabel.text = "Рейтинг:"
        countriesFilterLabel.text = "Страна:"
        genresFilterLabel.text = "Жанр:"
        
        [yearFilterLabel, yearValueLabel, ratingFilterLabel, ratingValueLabel, countriesFilterLabel, genresFilterLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 20)
            $0.textColor = ThemeColor.oppColor?.withAlphaComponent(0.5)
        }
    }
    
    func setupSubmitButton() {
        submitButton.setTitle("Применить", for: .normal)
        submitButton.backgroundColor = ThemeColor.generalColor
        submitButton.layer.cornerRadius = 16
        submitButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc func yearSliderChanged(slider: MultiSlider) {
        presenter?.yearSliderChanged(slider: slider)
    }
    
    @objc func ratingSliderChanged(slider: MultiSlider) {
        presenter?.ratingSliderChanged(slider: slider)
    }
    
    @objc func didTapSubmitButton() {
        presenter?.didTapSubmitButton()
    }
}
