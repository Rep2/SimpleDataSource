import UIKit

public protocol DequeuableCollectionViewCellViewModel {
    associatedtype Cell: UICollectionViewCell

    var didTapCell: (() -> Void)? { get }

    func dequeueReusableCell(forRowAt indexPath: IndexPath, onCollectionView collectionView: UICollectionView) -> Cell
    func registerTableViewCell(onCollectionView collectionView: UICollectionView)
    func configure(cell: Cell)
}

extension DequeuableCollectionViewCellViewModel where Cell: UICollectionViewCell {
    public var didTapCell: (() -> Void)? {
        return nil
    }

    public func dequeueReusableCell(forRowAt indexPath: IndexPath, onCollectionView collectionView: UICollectionView) -> Cell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as Cell

        self.configure(cell: cell)

        return cell
    }
}

extension DequeuableCollectionViewCellViewModel where Cell: UICollectionViewCell {
    public func registerTableViewCell(onCollectionView collectionView: UICollectionView) {
        collectionView.register(cell: Cell.self, reusableCellSource: .class)
    }

    public var collectionViewPresentable: AnyDequeuableCollectionViewCellViewModel {
        return AnyDequeuableCollectionViewCellViewModel(
            dequeueAndPresentCell: { (collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell in
                return self.dequeueReusableCell(forRowAt: indexPath, onCollectionView: collectionView)
            },
            registerCell: { (collectionView: UICollectionView) in
                self.registerTableViewCell(onCollectionView: collectionView)
            },
            didTapCell: self.didTapCell
        )
    }
}
