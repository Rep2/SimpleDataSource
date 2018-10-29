import UIKit

public class AnyDequeuableCollectionViewCellViewModel {
    public let dequeueAndPresentCellCallback: (UICollectionView, IndexPath) -> UICollectionViewCell
    public let registerCellCallback: (UICollectionView) -> Void

    public init(dequeueAndPresentCellCallback: @escaping (UICollectionView, IndexPath) -> UICollectionViewCell,
                registerCellCallback: @escaping (UICollectionView) -> Void) {
        self.dequeueAndPresentCellCallback = dequeueAndPresentCellCallback
        self.registerCellCallback = registerCellCallback
    }
}
