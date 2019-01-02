import UIKit

public protocol DequeuableTableViewCellViewModel {
    associatedtype TableViewCell: PresentingTableViewCell

    func dequeueReusableCell(forRowAt indexPath: IndexPath, onTableView tableView: UITableView) -> TableViewCell
    func registerTableViewCell(onTableView tableView: UITableView)
}

extension DequeuableTableViewCellViewModel where TableViewCell: UITableViewCell, TableViewCell.ViewModel == Self {
    public func dequeueReusableCell(forRowAt indexPath: IndexPath, onTableView tableView: UITableView) -> TableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TableViewCell

        cell.present(viewModel: self)

        return cell
    }
}

extension DequeuableTableViewCellViewModel where TableViewCell: UITableViewCell {
    public func registerTableViewCell(onTableView tableView: UITableView) {
        tableView.register(cell: TableViewCell.self, reusableCellSource: TableViewCell.source)
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
