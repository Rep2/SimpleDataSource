import DequeueableDataSource
import UIKit

struct TextTableViewCellViewModel: DequeuableTableViewCellViewModel {
    typealias TableViewCell = TextTableViewCell

    let text: String
}

class TextTableViewCell: UITableViewCell, PresentingTableViewCell {
    public func present(viewModel: TextTableViewCellViewModel) {
        textLabel?.text = viewModel.text
    }
}
