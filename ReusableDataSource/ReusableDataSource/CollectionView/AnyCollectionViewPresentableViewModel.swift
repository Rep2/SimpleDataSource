import UIKit

public class AnyCollectionViewPresentableViewModel {
    let dequeueAndPresentCellCallback: (UICollectionView) -> UICollectionViewCell
    let registerCellCallback: (UICollectionView) -> Void

    public init<Presenter: ReusableViewModelPresenter>(base: ReusableViewModel<Presenter>) where Presenter: UICollectionViewCell {
        self.dequeueAndPresentCellCallback = { (collectionView: UICollectionView) -> UICollectionViewCell in
            collectionView.dequeueAndPresent(presentableViewModel: base, for: IndexPath(item: 0, section: 0))
        }

        self.registerCellCallback = { (collectionView: UICollectionView) in
            collectionView.register(cell: Presenter.self, reusableCellSource: Presenter.source)
        }
    }
}

extension ReusableViewModel where Presenter: UICollectionViewCell {
    public var any: AnyCollectionViewPresentableViewModel {
        return AnyCollectionViewPresentableViewModel(base: self)
    }
}
