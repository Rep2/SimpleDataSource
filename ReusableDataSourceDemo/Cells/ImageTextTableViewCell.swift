import ReusableDataSource
import UIKit

struct ImageTextTableViewCellViewModel {
    let textViewModel: String
    let imageViewModel: UIImage
}

class ImageTextTableViewCell: UITableViewCell, ReusablePresenter {
    func present(viewModel: ImageTextTableViewCellViewModel) {
        textLabel?.text = viewModel.textViewModel
        imageView?.image = viewModel.imageViewModel
    }
}
