import DequeueableDataSource
import UIKit

struct ImageTextTableViewCellViewModel: DequeuableTableViewCellViewModel {
    typealias TableViewCell = ImageTextTableViewCell

    let textViewModel: String
    let imageViewModel: UIImage
}

class ImageTextTableViewCell: UITableViewCell, PresentingTableViewCell {
    func present(viewModel: ImageTextTableViewCellViewModel) {
        textLabel?.text = viewModel.textViewModel
        imageView?.image = viewModel.imageViewModel
    }
}
