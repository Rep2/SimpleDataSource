import UIKit

public class AnyCollectionViewPresentableViewModel {
    let dequeueAndPresentCellCallback: (UICollectionView, IndexPath) -> UICollectionViewCell
    let registerCellCallback: (UICollectionView) -> Void

    public init<Presenter: ReusablePresenter>(base: ReusableViewModel<Presenter>) where Presenter: UICollectionViewCell {
        self.dequeueAndPresentCellCallback = { (collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell in
            collectionView.dequeueAndPresent(presentableViewModel: base, for: indexPath)
        }

        self.registerCellCallback = { (collectionView: UICollectionView) in
            collectionView.register(cell: Presenter.self, reusableCellSource: Presenter.source)
        }
    }
}

extension ReusableViewModel where Presenter: UICollectionViewCell {
    public var anyPresentable: AnyCollectionViewPresentableViewModel {
        return AnyCollectionViewPresentableViewModel(base: self)
    }
}
