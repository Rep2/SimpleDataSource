import TableViewCellSimpleDequeue

protocol DequeuableTableViewCellViewModel {
    associatedtype TableViewCell: PresentingTableViewCell

    func dequeueReusableCell(forRowAt indexPath: IndexPath, onTableView tableView: UITableView) -> TableViewCell
    func registerTableViewCell(onTableView tableView: UITableView)
}

extension DequeuableTableViewCellViewModel where TableViewCell: UITableViewCell, TableViewCell.ViewModel == Self {
    func dequeueReusableCell(forRowAt indexPath: IndexPath, onTableView tableView: UITableView) -> TableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TableViewCell

        cell.present(viewModel: self)

        return cell
    }
}

extension DequeuableTableViewCellViewModel where TableViewCell: UITableViewCell {
    func registerTableViewCell(onTableView tableView: UITableView) {
        tableView.register(cell: TableViewCell.self, reusableCellSource: TableViewCell.source)
    }

    var tableViewPresentable: AnyDequeuableTableViewCellViewModel {
        return AnyDequeuableTableViewCellViewModel(
            dequeueAndPresentCellCallback: { (tableView: UITableView, indexPath: IndexPath) -> UITableViewCell in
                return self.dequeueReusableCell(forRowAt: indexPath, onTableView: tableView)
            },
            registerCellCallback: { (tableView: UITableView) in
                self.registerTableViewCell(onTableView: tableView)
            }
        )
    }
}
