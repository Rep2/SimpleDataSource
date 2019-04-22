import UIKit

public class AnyDequeuableTableViewCellViewModel {
    public let dequeueAndPresentCell: (UITableView, IndexPath) -> UITableViewCell
    public let registerCell: (UITableView) -> Void
    public let didTapCell: (() -> Void)?

    public init(dequeueAndPresentCell: @escaping (UITableView, IndexPath) -> UITableViewCell,
                registerCell: @escaping (UITableView) -> Void,
                didTapCell: (() -> Void)? = nil) {
        self.dequeueAndPresentCell = dequeueAndPresentCell
        self.registerCell = registerCell
        self.didTapCell = didTapCell
    }
}
