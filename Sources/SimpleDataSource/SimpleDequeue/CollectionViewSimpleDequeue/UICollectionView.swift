import UIKit

extension UICollectionView {
    /**
     Registers a reusable "cell" using `CustomStringConvertible` as the reuese identifier.

     - Important: Call before `dequeueReusableCell(for:)` to avoid `NSInternalInconsistencyException`.
     */
    public func register<T: UICollectionViewCell>(cell: T.Type, reusableCellSource: CellSource) {
        switch reusableCellSource {
        case .nib:
            register(UINib(nibName: String(describing: cell), bundle: nil), forCellWithReuseIdentifier: String(describing: cell.self))
        case .class, .storyboard:
            register(cell, forCellWithReuseIdentifier: String(describing: cell.self))
        }
    }

    /**
     Returns a "cell" of a given type using `CustomStringConvertible` as the reuese identifier.

     - Important: Force unwraps the "cell". Causes the app to crashes with `NSInternalInconsistencyException` if the cell type isn't previously registered.
     */
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(for: indexPath)!
    }

    /**
     Returns an optional "cell" of a given type using `CustomStringConvertible` as the reuese identifier.

     - Important: Causes the app to crashes with `NSInternalInconsistencyException` if the cell type isn't previously registered.
     */
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T
    }
}
