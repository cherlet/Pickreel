import UIKit
import MultiSlider

protocol FiltersViewProtocol: AnyObject {
    func update(filter: Filter)
}

class FiltersViewController: UIViewController {
    // MARK: Properties
    var presenter: FiltersPresenterProtocol?
    private var selectedGenreIndex: IndexPath?
    private var heightConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    private let heightConstant: CGFloat = 480
    private let alphaConstant: CGFloat = 0.6

    // MARK: UI Elements
    private lazy var genreCollectionView = UICollectionView.getGenreCollection()
    
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
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fadeIn()
    }
}

// MARK: Module 
extension FiltersViewController: FiltersViewProtocol {
    func update(filter: Filter) {
        let years = filter.years ?? (left: 1930, right: 2030)
        let ratings = filter.ratings ?? (left: 0.0, right: 10.0)
        let genreIndex = Genres.findIndex(of: filter.genre)
        
        DispatchQueue.main.async {
            self.yearValueLabel.text = "\(years.left) - \(years.right)"
            self.yearSlider.value = [CGFloat(years.left), CGFloat(years.right)]
            
            self.ratingValueLabel.text = "\(ratings.left) - \(ratings.right)"
            self.ratingSlider.value = [CGFloat(ratings.left), CGFloat(ratings.right)]
            
            if let index = genreIndex {
                self.selectedGenreIndex = IndexPath(row: index, section: 0)
                self.genreCollectionView.selectItem(at: self.selectedGenreIndex, animated: false, scrollPosition: UICollectionView.ScrollPosition.left)
            }
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
        
        [yearStack, yearSlider, ratingStack, ratingSlider, genresFilterLabel, genreCollectionView, submitButton].forEach {
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
            ratingStack.leadingAnchor.constraint(equalTo: filtersSubview.leadingAnchor, constant: 16),
            ratingStack.trailingAnchor.constraint(equalTo: filtersSubview.trailingAnchor, constant: -16),
            
            ratingSlider.topAnchor.constraint(equalTo: ratingStack.bottomAnchor, constant: 8),
            ratingSlider.leadingAnchor.constraint(equalTo: filtersSubview.leadingAnchor, constant: 20),
            ratingSlider.trailingAnchor.constraint(equalTo: filtersSubview.trailingAnchor, constant: -20),
            
            genresFilterLabel.topAnchor.constraint(equalTo: ratingSlider.bottomAnchor, constant: 16),
            genresFilterLabel.leadingAnchor.constraint(equalTo: filtersSubview.leadingAnchor, constant: 16),
            
            genreCollectionView.topAnchor.constraint(equalTo: genresFilterLabel.bottomAnchor, constant: 12),
            genreCollectionView.leadingAnchor.constraint(equalTo: filtersSubview.leadingAnchor, constant: 20),
            genreCollectionView.trailingAnchor.constraint(equalTo: filtersSubview.trailingAnchor, constant: -20),
            genreCollectionView.heightAnchor.constraint(equalToConstant: 32),
            
            submitButton.widthAnchor.constraint(lessThanOrEqualTo: filtersSubview.widthAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 40),
            submitButton.bottomAnchor.constraint(equalTo: filtersSubview.bottomAnchor, constant: -64),
            submitButton.leadingAnchor.constraint(equalTo: filtersSubview.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: filtersSubview.trailingAnchor, constant: -16)
        ])
    }
    
    func setupSubviews() {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(fadeOut))
        swipeGestureRecognizer.direction = .down
        filtersSubview.backgroundColor = ThemeColor.background
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
        yearSlider.outerTrackColor = ThemeColor.contrast
        yearSlider.orientation = .horizontal
        yearSlider.tintColor = ThemeColor.general?.withAlphaComponent(0.5)
        yearSlider.thumbTintColor = ThemeColor.white
        yearSlider.hasRoundTrackEnds = true
        yearSlider.addTarget(self, action: #selector(yearSliderChanged), for: .valueChanged)
        
        ratingSlider.minimumValue = 0
        ratingSlider.maximumValue = 10
        yearSlider.snapStepSize = 0.1
        ratingSlider.outerTrackColor = ThemeColor.contrast
        ratingSlider.orientation = .horizontal
        ratingSlider.tintColor = ThemeColor.general?.withAlphaComponent(0.5)
        ratingSlider.thumbTintColor = ThemeColor.white
        ratingSlider.addTarget(self, action: #selector(ratingSliderChanged), for: .valueChanged)
    }
    
    func setupSectionLabels() {
        yearFilterLabel.text = "Год:"
        ratingFilterLabel.text = "Рейтинг:"
        genresFilterLabel.text = "Жанр:"
        
        [yearFilterLabel, yearValueLabel, ratingFilterLabel, ratingValueLabel, genresFilterLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 20)
            $0.textColor = ThemeColor.opp?.withAlphaComponent(0.5)
        }
    }
    
    func setupSubmitButton() {
        submitButton.setTitle("Применить", for: .normal)
        submitButton.backgroundColor = ThemeColor.general
        submitButton.layer.cornerRadius = 16
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
    }
    
    // MARK: Actions
    @objc func yearSliderChanged(slider: MultiSlider) {
        presenter?.yearSliderChanged(slider: slider)
    }
    
    @objc func ratingSliderChanged(slider: MultiSlider) {
        presenter?.ratingSliderChanged(slider: slider)
    }
    
    @objc func handleSubmit() {
        let genre = selectedGenreIndex != nil ? Genres.all.ru[selectedGenreIndex!.row] : nil
        presenter?.handleSubmit(genre: genre)
        fadeOut()
    }
}

// MARK: - GenreCollectionView DataSource/Delegate
extension FiltersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Genres.all.ru.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell else {
            fatalError("DEBUG: Failed with custom cell bug")
        }
        
        let genre = Genres.all.ru[indexPath.row]
        cell.configure(genre: genre, forFilters: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath == selectedGenreIndex {
            collectionView.deselectItem(at: indexPath, animated: false)
            selectedGenreIndex = nil
        } else {
            selectedGenreIndex = indexPath
        }
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
