import UIKit

public class AnyDequeuableTableViewCellViewModel {
    public let dequeueAndPresentCell: (UITableView, IndexPath) -> UITableViewCell
    public let registerCell: (UITableView) -> Void

    public init(dequeueAndPresentCell: @escaping (UITableView, IndexPath) -> UITableViewCell,
                registerCell: @escaping (UITableView) -> Void) {
        self.dequeueAndPresentCell = dequeueAndPresentCell
        self.registerCell = registerCell
    }
}
