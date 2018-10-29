import CollectionViewSimpleDequeue

public protocol DequeuableCollectionViewCellViewModel {
    associatedtype CollectionViewCell: PresentingTableViewCell

    func dequeueReusableCell(forRowAt indexPath: IndexPath, onCollectionView collectionView: UICollectionView) -> CollectionViewCell
    func registerTableViewCell(onCollectionView collectionView: UICollectionView)
}

extension DequeuableCollectionViewCellViewModel where CollectionViewCell: UICollectionViewCell, CollectionViewCell.ViewModel == Self {
    public func dequeueReusableCell(forRowAt indexPath: IndexPath, onCollectionView collectionView: UICollectionView) -> CollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as CollectionViewCell

        cell.present(viewModel: self)

        return cell
    }
}

extension DequeuableCollectionViewCellViewModel where CollectionViewCell: UICollectionViewCell {
    public func registerTableViewCell(onCollectionView collectionView: UICollectionView) {
        collectionView.register(cell: CollectionViewCell.self, reusableCellSource: CollectionViewCell.source)
    }

    public var tableViewPresentable: AnyDequeuableCollectionViewCellViewModel {
        return AnyDequeuableCollectionViewCellViewModel(
            dequeueAndPresentCellCallback: { (collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell in
                return self.dequeueReusableCell(forRowAt: indexPath, onCollectionView: collectionView)
            },
            registerCellCallback: { (collectionView: UICollectionView) in
                self.registerTableViewCell(onCollectionView: collectionView)
            }
        )
    }
}
