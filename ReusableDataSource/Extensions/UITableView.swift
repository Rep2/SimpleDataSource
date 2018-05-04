import UIKit

extension UITableView {
    /**
     Registers a reusable "cell" using `CustomStringConvertible` as the reuese identifier.

     - Important: Call before `dequeueReusableCell(for:)` to avoid `NSInternalInconsistencyException`.
     */
    public func register<T: UITableViewCell>(cell: T.Type, reusableCellSource: ReusableViewSource) {
        switch reusableCellSource {
        case .nib:
            register(UINib(nibName: String(describing: cell), bundle: nil), forCellReuseIdentifier: String(describing: cell))
        case .class, .storyboard:
            register(T.self, forCellReuseIdentifier: String(describing: cell.self))
        }
    }

    /**
     Returns a "cell" of a given type using `CustomStringConvertible` as the reuese identifier.

     - Important: Force unwraps the "cell". Causes the app to crashes with `NSInternalInconsistencyException` if the cell type isn't previously registered.
     */
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(for: indexPath)!
    }

    /**
     Returns an optional "cell" of a given type using `CustomStringConvertible` as the reuese identifier.

     - Important: Causes the app to crashes with `NSInternalInconsistencyException` if the cell type isn't previously registered.
     */
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T
    }

    /**
     Returns a "cell" on which `presentableViewModel` was presented.

     - Important: Causes the app to crashes with `NSInternalInconsistencyException` if the `PresentingCell` type isn't previously registered.
     */
    func dequeueAndPresent<Presenter: ReusableViewModelPresenter>(presentableViewModel: ReusableViewModel<Presenter>, for indexPath: IndexPath) -> Presenter
        where Presenter: UITableViewCell {
        let cell = dequeueReusableCell(for: indexPath) as Presenter

        cell.present(viewModel: presentableViewModel.viewModel)

        return cell
    }
}
