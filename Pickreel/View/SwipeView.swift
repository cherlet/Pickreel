import UIKit

class SwipeView: UIView {
    // MARK: Properties
    private var frontView = UIView()
    private var backView = UIScrollView()
    private var isFlipped = false
    
    // MARK: UI Elements
    private lazy var swipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var yearIcon = UIImageView(iconName: "calendar", color: .white)
    private lazy var ratingIcon = UIImageView(iconName: "star.fill", color: .white)
    private lazy var nameLabel = UILabel(textColor: .white, font: UIFont.systemFont(ofSize: 36, weight: .bold), numberOfLines: 0)
    private lazy var yearLabel = UILabel(textColor: .white, font: UIFont.systemFont(ofSize: 20))
    private lazy var ratingLabel = UILabel(textColor: .white, font: UIFont.systemFont(ofSize: 20))
    
    // MARK: Initialize
    init() {
        super.init(frame: .zero)
        self.setup()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup() {
        layer.cornerRadius = 16
        frontView.layer.cornerRadius = 16
        setupLayout()
    }
    
    private func setupLayout() {
        frontView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(frontView)
        
        [swipeImage, nameLabel, yearLabel, ratingLabel, ratingIcon, yearIcon].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            frontView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            frontView.topAnchor.constraint(equalTo: topAnchor),
            frontView.leadingAnchor.constraint(equalTo: leadingAnchor),
            frontView.trailingAnchor.constraint(equalTo: trailingAnchor),
            frontView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            ratingIcon.bottomAnchor.constraint(equalTo: frontView.bottomAnchor, constant: -48),
            ratingIcon.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 16),
            
            ratingLabel.centerYAnchor.constraint(equalTo: ratingIcon.centerYAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: ratingIcon.trailingAnchor, constant: 8),
            
            yearIcon.bottomAnchor.constraint(equalTo: ratingIcon.topAnchor, constant: -16),
            yearIcon.leadingAnchor.constraint(equalTo: ratingIcon.leadingAnchor),
            
            yearLabel.centerYAnchor.constraint(equalTo: yearIcon.centerYAnchor),
            yearLabel.leadingAnchor.constraint(equalTo: yearIcon.trailingAnchor, constant: 8),
            
            nameLabel.bottomAnchor.constraint(equalTo: yearIcon.topAnchor, constant: -16),
            nameLabel.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -16),
            
            swipeImage.topAnchor.constraint(equalTo: frontView.topAnchor),
            swipeImage.leadingAnchor.constraint(equalTo: frontView.leadingAnchor),
            swipeImage.trailingAnchor.constraint(equalTo: frontView.trailingAnchor),
            swipeImage.bottomAnchor.constraint(equalTo: frontView.bottomAnchor)
        ])
    }
}

// MARK: - Methods
extension SwipeView {
    func update(with media: Media) {
        closeReview()
        backView = ReView(media: media)
        
        nameLabel.text = media.title.ru
        yearLabel.text = String(media.year)
        ratingLabel.text = String(media.rating.imdb)
        
        if let url = URL(string: media.posterURL ?? "") {
            swipeImage.load(url: url)
        } else {
            // TODO: - Add image placeholder
        }
    }
    
    func setGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.withAlphaComponent(0.5).cgColor]
        gradient.cornerRadius = 16
        gradient.frame = swipeImage.bounds
        swipeImage.layer.sublayers?.removeAll()
        swipeImage.layer.addSublayer(gradient)
    }
    
    private func closeReview() {
        if isFlipped {
            isFlipped = false
            frontView.isHidden = false
            backView.removeFromSuperview()
        }
    }
    
    @objc private func handleTap() {
        if isFlipped {
            UIView.transition(from: backView, to: frontView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            isFlipped = false
        } else {
            addSubview(backView)
            backView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                backView.topAnchor.constraint(equalTo: topAnchor),
                backView.leadingAnchor.constraint(equalTo: leadingAnchor),
                backView.trailingAnchor.constraint(equalTo: trailingAnchor),
                backView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            
            UIView.transition(from: frontView, to: backView, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            isFlipped = true
        }
    }

}

