import ReusableDataSource
import UIKit

struct TextTableViewCellViewModel {
    let textViewModel: String
}

class TextTableViewCell: UITableViewCell, ReusableViewModelPresenter {
    public func present(viewModel: TextTableViewCellViewModel) {
        textLabel?.text = viewModel.textViewModel
    }
}
