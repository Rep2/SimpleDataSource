import CollectionViewSimpleDequeue

protocol DequeuableCollectionViewCellViewModel {
    associatedtype CollectionViewCell: PresentingTableViewCell

    func dequeueReusableCell(forRowAt indexPath: IndexPath, onCollectionView collectionView: UICollectionView) -> CollectionViewCell
    func registerTableViewCell(onCollectionView collectionView: UICollectionView)
}

extension DequeuableCollectionViewCellViewModel where CollectionViewCell: UICollectionViewCell, CollectionViewCell.ViewModel == Self {
    func dequeueReusableCell(forRowAt indexPath: IndexPath, onCollectionView collectionView: UICollectionView) -> CollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as CollectionViewCell

        cell.present(viewModel: self)

        return cell
    }
}

extension DequeuableCollectionViewCellViewModel where CollectionViewCell: UICollectionViewCell {
    func registerTableViewCell(onCollectionView collectionView: UICollectionView) {
        collectionView.register(cell: CollectionViewCell.self, reusableCellSource: CollectionViewCell.source)
    }

    var tableViewPresentable: AnyCollectionViewPresentableViewModel {
        return AnyCollectionViewPresentableViewModel(
            dequeueAndPresentCellCallback: { (collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell in
                return self.dequeueReusableCell(forRowAt: indexPath, onCollectionView: collectionView)
            },
            registerCellCallback: { (collectionView: UICollectionView) in
                self.registerTableViewCell(onCollectionView: collectionView)
            }
        )
    }
}
