import UIKit

class PersonCell: UICollectionViewCell {
    // MARK: Properties
    static let castIdentifier = "CastCell"
    static let crewIdentifier = "CrewCell"
    
    // MARK: UI Elements
    private lazy var name = UILabel(textColor: ThemeColor.white, fontSize: 16, fontWeight: .semibold, numberOfLines: 0)
    private lazy var character = UILabel(textColor: ThemeColor.silent, fontSize: 16)
    private lazy var image = UIImageView(clipsToBounds: true, contentMode: .scaleAspectFill)
    
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
    
    func configure(name: String, role: String, posterURL: String?) {
        self.name.text = name
        character.text = role
        
        if let posterURL = posterURL, let url = URL(string: posterURL) {
            image.load(url: url)
        } else {
            // TODO: - Add image placeholder
        }
    }
}
