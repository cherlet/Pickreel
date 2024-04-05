import UIKit

class CastCell: UICollectionViewCell {
    // MARK: Properties
    static let identifier = "CastCell"
    
    // MARK: UI Elements
    private lazy var name: UILabel = {
        let label = UILabel()
        label.textColor = ThemeColor.oppColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var character: UILabel = {
        let label = UILabel()
        label.textColor = ThemeColor.silentColor
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    func setupLayout() {
        let labelStack = UIStackView(arrangedSubviews: [name, character])
        labelStack.axis = .vertical
        labelStack.spacing = 2
        
        [labelStack, image].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.heightAnchor.constraint(equalToConstant: 80),
            image.widthAnchor.constraint(equalToConstant: 48),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            labelStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelStack.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            labelStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
        
    }
    
    func configure(with actor: Actor) {
        name.text = actor.nameRu
        character.text = actor.character
        
        if let posterURL = actor.posterURL, let url = URL(string: posterURL) {
            image.load(url: url)
        } else {
            // TODO: - Add image placeholder
        }
    }
}
