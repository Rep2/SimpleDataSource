import UIKit

public class AnyDequeuableCollectionViewCellViewModel {
    public let dequeueAndPresentCell: (UICollectionView, IndexPath) -> UICollectionViewCell
    public let registerCell: (UICollectionView) -> Void

    public init(dequeueAndPresentCellCallback: @escaping (UICollectionView, IndexPath) -> UICollectionViewCell,
                registerCellCallback: @escaping (UICollectionView) -> Void) {
        self.dequeueAndPresentCell = dequeueAndPresentCellCallback
        self.registerCell = registerCellCallback
    }
}
