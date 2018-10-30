import UIKit

public class AnyDequeuableCollectionViewCellViewModel {
    public let dequeueAndPresentCell: (UICollectionView, IndexPath) -> UICollectionViewCell
    public let registerCell: (UICollectionView) -> Void

    public init(dequeueAndPresentCell: @escaping (UICollectionView, IndexPath) -> UICollectionViewCell,
                registerCell: @escaping (UICollectionView) -> Void) {
        self.dequeueAndPresentCell = dequeueAndPresentCell
        self.registerCell = registerCell
    }
}
