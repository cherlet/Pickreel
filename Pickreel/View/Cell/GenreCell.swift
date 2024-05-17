import UIKit

class GenreCell: UICollectionViewCell {
    // MARK: Properties
    static let identifier = "GenreCell"
    private var color = ThemeColor.contrast
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.layer.borderWidth = 2
            } else {
                contentView.layer.borderWidth = 0
            }
        }
    }
    
    // MARK: UI Elements
    private lazy var label = UILabel(fontSize: 16)
    private lazy var icon = UIImageView(iconName: "comedy", isCustom: true)
    
    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = ThemeColor.white
        contentView.layer.cornerRadius = 16
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    func setupLayout() {
        [icon, label].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            icon.heightAnchor.constraint(equalToConstant: 16),
            
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    func configure(genre: String, forFilters: Bool = false) {
        guard let association = Genres.getAssociations(of: genre), let image = association.icon else { return }
        
        color = association.color
        
        label.text = genre.prefix(1).uppercased() + genre.dropFirst()
        label.textColor = color
        
        icon.image = image
        
        contentView.layer.borderColor = color?.cgColor
        
        if !forFilters {
            isUserInteractionEnabled = false
            contentView.layer.borderWidth = 2
        }
    }
}
