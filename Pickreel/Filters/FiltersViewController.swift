import UIKit
import MultiSlider

protocol FiltersViewProtocol: AnyObject {
    func update(years: (Int, Int))
    func update(ratings: (Double, Double))
}

class FiltersViewController: UIViewController {
    // MARK: Properties
    var presenter: FiltersPresenterProtocol?
    private var heightConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    private let heightConstant: CGFloat = 460
    private let alphaConstant: CGFloat = 0.6

    // MARK: UI Elements
    private let filtersSubview = UIView()
    private let dimmedSubview = UIView()
    private let yearFilterLabel = UILabel()
    private let yearValueLabel = UILabel()
    private let yearSlider = MultiSlider()
    private let ratingFilterLabel = UILabel()
    private let ratingValueLabel = UILabel()
    private let ratingSlider = MultiSlider()
    private let genresFilterLabel = UILabel()
    private let submitButton = UIButton()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fadeIn()
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
        view.backgroundColor = .clear
        setupSubviews()
        setupSliders()
        setupSectionLabels()
        setupSubmitButton()
        setupLayout()
    }
    
    func setupLayout() {
        // MARK: Layout on main view
        [dimmedSubview, filtersSubview].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            dimmedSubview.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedSubview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedSubview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedSubview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            filtersSubview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filtersSubview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        heightConstraint = filtersSubview.heightAnchor.constraint(equalToConstant: heightConstant)
        bottomConstraint = filtersSubview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: heightConstant)
        
        heightConstraint?.isActive = true
        bottomConstraint?.isActive = true
        
        // MARK: Layout on filters subview
        let yearStack = UIStackView(arrangedSubviews: [yearFilterLabel, yearValueLabel])
        let ratingStack = UIStackView(arrangedSubviews: [ratingFilterLabel, ratingValueLabel])
        
        [yearStack, ratingStack].forEach {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
        }
        
        [yearStack, yearSlider, ratingStack, ratingSlider, genresFilterLabel, submitButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            filtersSubview.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            yearStack.topAnchor.constraint(equalTo: filtersSubview.topAnchor, constant: 32),
            yearStack.leadingAnchor.constraint(equalTo: filtersSubview.leadingAnchor, constant: 16),
            yearStack.trailingAnchor.constraint(equalTo: filtersSubview.trailingAnchor, constant: -16),
            
            yearSlider.topAnchor.constraint(equalTo: yearStack.bottomAnchor, constant: 8),
            yearSlider.leadingAnchor.constraint(equalTo: filtersSubview.leadingAnchor, constant: 20),
            yearSlider.trailingAnchor.constraint(equalTo: filtersSubview.trailingAnchor, constant: -20),
            
            ratingStack.topAnchor.constraint(equalTo: yearSlider.bottomAnchor, constant: 16),
            ratingStack.leadingAnchor.constraint(equalTo: yearStack.leadingAnchor),
            ratingStack.trailingAnchor.constraint(equalTo: yearStack.trailingAnchor),
            
            ratingSlider.topAnchor.constraint(equalTo: ratingStack.bottomAnchor, constant: 8),
            ratingSlider.leadingAnchor.constraint(equalTo: yearSlider.leadingAnchor),
            ratingSlider.trailingAnchor.constraint(equalTo: yearSlider.trailingAnchor),
            
            genresFilterLabel.topAnchor.constraint(equalTo: ratingSlider.bottomAnchor, constant: 16),
            genresFilterLabel.leadingAnchor.constraint(equalTo: yearStack.leadingAnchor),
            
            submitButton.widthAnchor.constraint(lessThanOrEqualTo: filtersSubview.widthAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 40),
            submitButton.bottomAnchor.constraint(equalTo: filtersSubview.bottomAnchor, constant: -64),
            submitButton.leadingAnchor.constraint(equalTo: yearStack.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: filtersSubview.trailingAnchor, constant: -16)
        ])
    }
    
    func setupSubviews() {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(fadeOut))
        swipeGestureRecognizer.direction = .down
        filtersSubview.backgroundColor = ThemeColor.backgroundColor
        filtersSubview.layer.cornerRadius = 16
        filtersSubview.clipsToBounds = true
        filtersSubview.addGestureRecognizer(swipeGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(fadeOut))
        dimmedSubview.backgroundColor = .black
        dimmedSubview.alpha = 0
        dimmedSubview.addGestureRecognizer(tapGestureRecognizer)
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
        yearFilterLabel.text = "Год:"
        ratingFilterLabel.text = "Рейтинг:"
        genresFilterLabel.text = "Жанр:"
        
        [yearFilterLabel, yearValueLabel, ratingFilterLabel, ratingValueLabel, genresFilterLabel].forEach {
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
        fadeOut()
    }
}

// MARK: - Animation Methods
private extension FiltersViewController {
    @objc func fadeOut() {
        dimmedSubview.alpha = alphaConstant
        UIView.animate(withDuration: 0.15) {
            self.dimmedSubview.alpha = 0
            self.bottomConstraint?.constant = self.heightConstant
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }

    func fadeIn() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.15) {
            self.dimmedSubview.alpha = self.alphaConstant
            self.bottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}
