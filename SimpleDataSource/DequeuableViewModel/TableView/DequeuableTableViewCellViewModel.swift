import UIKit

public protocol DequeuableTableViewCellViewModel {
    associatedtype Cell: UITableViewCell

    func dequeueReusableCell(forRowAt indexPath: IndexPath, onTableView tableView: UITableView) -> Cell
    func registerTableViewCell(onTableView tableView: UITableView)
    func configure(cell: Cell)
}

extension DequeuableTableViewCellViewModel where Cell: UITableViewCell {
    public func dequeueReusableCell(forRowAt indexPath: IndexPath, onTableView tableView: UITableView) -> Cell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as Cell

        self.configure(cell: cell)

        return cell
    }
}

extension DequeuableTableViewCellViewModel where Cell: UITableViewCell {
    public func registerTableViewCell(onTableView tableView: UITableView) {
        tableView.register(cell: Cell.self, reusableCellSource: .class)
    }

    public var tableViewPresentable: AnyDequeuableTableViewCellViewModel {
        return AnyDequeuableTableViewCellViewModel(
            dequeueAndPresentCell: { (tableView: UITableView, indexPath: IndexPath) -> UITableViewCell in
                return self.dequeueReusableCell(forRowAt: indexPath, onTableView: tableView)
            },
            registerCell: { (tableView: UITableView) in
                self.registerTableViewCell(onTableView: tableView)
            }
        )
    }
}
