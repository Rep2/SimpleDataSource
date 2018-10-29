import UIKit

public class AnyCollectionViewPresentableViewModel {
    public let dequeueAndPresentCellCallback: (UICollectionView, IndexPath) -> UICollectionViewCell
    public let registerCellCallback: (UICollectionView) -> Void

    init(dequeueAndPresentCellCallback: @escaping (UICollectionView, IndexPath) -> UICollectionViewCell,
         registerCellCallback: @escaping (UICollectionView) -> Void) {
        self.dequeueAndPresentCellCallback = dequeueAndPresentCellCallback
        self.registerCellCallback = registerCellCallback
    }
}
