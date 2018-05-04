import ReusableDataSource
import UIKit

class ViewController: UITableViewController {
    let dataSource = ReusableTableViewDataSource()

    lazy var viewModels = [
        ReusableViewModel<TextTableViewCell>(viewModel: "Cell 1").anyPresentable,
        ReusableViewModel<TextTableViewCell>(viewModel: "Cell 2").anyPresentable,
        ReusableViewModel<ImageTextTableViewCell>(viewModel: ImageTextTableViewCellViewModel(textViewModel: "Cell 3", imageViewModel: #imageLiteral(resourceName: "filter"))).anyPresentable,
        ReusableViewModel<TextTableViewCell>(viewModel: "Cell 2").anyPresentable
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource

        dataSource.present(presentableViewModels: viewModels, on: tableView)
    }
}
