import UIKit

public class AnyTableViewPresentableViewModel {
    public let dequeueAndPresentCellCallback: (UITableView, IndexPath) -> UITableViewCell
    public let registerCellCallback: (UITableView) -> Void

    public init<Presenter: ReusablePresenter>(base: ReusableViewModel<Presenter>) where Presenter: UITableViewCell {
        self.dequeueAndPresentCellCallback = { (tableView: UITableView, indexPath: IndexPath) -> UITableViewCell in
            tableView.dequeueAndPresent(presentableViewModel: base, for: indexPath)
        }

        self.registerCellCallback = { (tableView: UITableView) in
            tableView.register(cell: Presenter.self, reusableCellSource: Presenter.source)
        }
    }
}

extension ReusableViewModel where Presenter: UITableViewCell {
    public var anyPresentable: AnyTableViewPresentableViewModel {
        return AnyTableViewPresentableViewModel(base: self)
    }
}
