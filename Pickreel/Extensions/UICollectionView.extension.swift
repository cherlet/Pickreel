import UIKit

extension UICollectionView {
    static func getGenreCollection(identifier: String = GenreCell.identifier, tag: Int = 0) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.estimatedItemSize = CGSize(width: 1, height: 32)
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.tag = tag
        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: identifier)
        return collectionView
    }
    
    static func getPersonCollection(identifier: String, tag: Int) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 80)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.tag = tag
        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: identifier)
        return collectionView
    }
}
