import AnyDataSource
import UIKit

class ViewController: UITableViewController {
    lazy var dataSource = AnyTableViewDataSource()

    var viewModels: [[AnyDequeuableTableViewCellViewModel]] = {
        return BestMoviesEverDataSource
            .movies
            .map {
                var movieViewModels = [$0.tableViewPresentable]

                movieViewModels.append(contentsOf: $0.actors.map { $0.tableViewPresentable })

                return movieViewModels
            }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Best movies ever"

        tableView.dataSource = dataSource

        dataSource.present(viewModels: viewModels, onTableView: tableView)
    }
}
