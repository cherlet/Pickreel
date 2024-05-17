import UIKit

class SwipeView: UIView {
    // MARK: UI Elements
    private lazy var swipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var yearIcon = UIImageView(iconName: "calendar")
    private lazy var ratingIcon = UIImageView(iconName: "star.fill")
    private lazy var nameLabel = UILabel(fontSize: 36, fontWeight: .bold, numberOfLines: 0)
    private lazy var yearLabel = UILabel(fontSize: 20)
    private lazy var ratingLabel = UILabel(fontSize: 20)
    
    // MARK: Initialize
    init(asFullscreen: Bool = false) {
        super.init(frame: .zero)
        setup(asFullscreen)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup(_ asFullscreen: Bool) {
        layer.cornerRadius = asFullscreen ? 0 : 16
        swipeImage.layer.cornerRadius = asFullscreen ? 0 : 16
        setupLayout()
    }
    
    private func setupLayout() {
        [swipeImage, nameLabel, yearLabel, ratingLabel, ratingIcon, yearIcon].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            swipeImage.topAnchor.constraint(equalTo: topAnchor),
            swipeImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            swipeImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            swipeImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            ratingIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -48),
            ratingIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            ratingLabel.centerYAnchor.constraint(equalTo: ratingIcon.centerYAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: ratingIcon.trailingAnchor, constant: 8),
            
            yearIcon.bottomAnchor.constraint(equalTo: ratingIcon.topAnchor, constant: -16),
            yearIcon.leadingAnchor.constraint(equalTo: ratingIcon.leadingAnchor),
            
            yearLabel.centerYAnchor.constraint(equalTo: yearIcon.centerYAnchor),
            yearLabel.leadingAnchor.constraint(equalTo: yearIcon.trailingAnchor, constant: 8),
            
            nameLabel.bottomAnchor.constraint(equalTo: yearIcon.topAnchor, constant: -16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}

// MARK: - Public Methods
extension SwipeView {
    func update(with media: Media) {
        nameLabel.text = media.title.ru
        yearLabel.text = String(media.year)
        ratingLabel.text = String(media.rating.imdb)
        
        if let posterURL = media.posterURL, let url = URL(string: posterURL) {
            swipeImage.load(url: url)
        } else {
            // TODO: - Add image placeholder
        }
    }
    
    func setEffects() {
        swipeImage.setGradient()
    }
}

