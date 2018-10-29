import UIKit

public class AnyDequeuableTableViewCellViewModel {
    public let dequeueAndPresentCell: (UITableView, IndexPath) -> UITableViewCell
    public let registerCell: (UITableView) -> Void

    public init(dequeueAndPresentCellCallback: @escaping (UITableView, IndexPath) -> UITableViewCell,
                registerCellCallback: @escaping (UITableView) -> Void) {
        self.dequeueAndPresentCell = dequeueAndPresentCellCallback
        self.registerCell = registerCellCallback
    }
}
