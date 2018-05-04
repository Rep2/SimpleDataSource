import ReusableDataSource
import UIKit

class TextTableViewCell: UITableViewCell, ReusablePresenter {
    public func present(viewModel: String) {
        textLabel?.text = viewModel
    }
}
