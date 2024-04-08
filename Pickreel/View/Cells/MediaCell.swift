import UIKit

class MediaCell: UITableViewCell {
    // MARK: Properties
    static let identifier = "MediaCell"
    
    // MARK: UI Elements
    private lazy var posterImageView = UIImageView(clipsToBounds: true, contentMode: .scaleAspectFill, cornerRadius: 8)
    private lazy var titleLabel = UILabel(textColor: ThemeColor.opp, fontSize: 20)
    private lazy var yearLabel = UILabel(textColor: ThemeColor.opp, fontSize: 16)
    private lazy var ratingLabel = UILabel(textColor: ThemeColor.opp, fontSize: 16)
    private lazy var yearIcon = UIImageView(iconName: "calendar", color: ThemeColor.opp)
    private lazy var ratingIcon = UIImageView(iconName: "star.fill", color: ThemeColor.opp)
    
    // MARK: Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setupLayout() {
        [posterImageView, titleLabel, yearLabel, ratingLabel, yearIcon, ratingIcon].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            posterImageView.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            
            yearIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            yearIcon.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            yearLabel.centerYAnchor.constraint(equalTo: yearIcon.centerYAnchor),
            yearLabel.leadingAnchor.constraint(equalTo: yearIcon.trailingAnchor, constant: 8),
            
            ratingIcon.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 8),
            ratingIcon.leadingAnchor.constraint(equalTo: yearIcon.leadingAnchor),
            
            ratingLabel.centerYAnchor.constraint(equalTo: ratingIcon.centerYAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: yearLabel.leadingAnchor),
        ])
    }

    
    func configure(with media: Media) {
        titleLabel.text = media.title.ru
        yearLabel.text = String(media.year)
        ratingLabel.text = String(media.rating.imdb)
        
        if let posterURL = media.posterURL, let url = URL(string: posterURL) {
            posterImageView.load(url: url)
        } else {
            // TODO: - Add image placeholder
        }
    }

}
