import UIKit

class GenreCell: UICollectionViewCell {
    // MARK: Properties
    static let identifier = "GenreCell"
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = ThemeColor.generalColor
            } else {
                contentView.backgroundColor = ThemeColor.contrastColor
            }
        }
    }
    
    // MARK: UI Elements
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = ThemeColor.oppColor
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = ThemeColor.contrastColor
        contentView.layer.cornerRadius = 8
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    func setupLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
    }
    
    func configure(title: String) {
        label.text = title.uppercased()
    }
}
