import UIKit

class MediaCell: UITableViewCell {
    // MARK: Properties
    static let identifier = "MediaCell"
    
    // MARK: UI Elements
    private lazy var poster = UIImageView(clipsToBounds: true, contentMode: .scaleAspectFill)
    private lazy var titleLabel = UILabel(textColor: ThemeColor.opp, fontSize: 14, fontWeight: .semibold)
    private lazy var originalTitleLabel = UILabel(textColor: ThemeColor.gray, fontSize: 14, fontWeight: .semibold)
    private lazy var ratingLabel = UILabel(textColor: ThemeColor.opp, fontSize: 16, fontWeight: .semibold)
    
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
        let titleStack = UIStackView(arrangedSubviews: [titleLabel, originalTitleLabel])
        titleStack.axis = .vertical
        titleStack.spacing = 2
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        
        let infoStack = UIStackView(arrangedSubviews: [titleStack, ratingLabel])
        infoStack.axis = .horizontal
        infoStack.distribution = .equalSpacing
        
        [poster, infoStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            poster.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            poster.heightAnchor.constraint(equalToConstant: 64),
            poster.widthAnchor.constraint(equalToConstant: 40),
            
            titleStack.widthAnchor.constraint(lessThanOrEqualToConstant: 260),
            
            infoStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            infoStack.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 8),
            infoStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }

    
    func configure(with media: Media) {
        titleLabel.text = media.title.ru
        let year = String(media.year)
        originalTitleLabel.text = media.title.original + ", \(year)"
        ratingLabel.setup(as: .rating, text: String(media.rating.imdb))
        
        if let posterURL = media.posterURL, let url = URL(string: posterURL) {
            poster.load(url: url)
        } else {
            // TODO: - Add image placeholder
        }
    }

}
