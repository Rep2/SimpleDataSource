import UIKit

public class AnyTableViewPresentableViewModel {
    public let dequeueAndPresentCellCallback: (UITableView) -> UITableViewCell
    public let registerCellCallback: (UITableView) -> Void

    public init<Presenter: ReusableViewModelPresenter>(base: PresentableViewModel<Presenter>) where Presenter: UITableViewCell {
        self.dequeueAndPresentCellCallback = { (tableView: UITableView) -> UITableViewCell in
            tableView.dequeueAndPresent(presentableViewModel: base, for: IndexPath(item: 0, section: 0))
        }

        self.registerCellCallback = { (tableView: UITableView) in
            tableView.register(cell: Presenter.self, reusableCellSource: Presenter.source)
        }
    }
}

extension PresentableViewModel where Presenter: UITableViewCell {
    public var anyPresentable: AnyTableViewPresentableViewModel {
        return AnyTableViewPresentableViewModel(base: self)
    }
}
