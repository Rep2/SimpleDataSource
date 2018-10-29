import UIKit

public class AnyTableViewPresentableViewModel {
    public let dequeueAndPresentCellCallback: (UITableView, IndexPath) -> UITableViewCell
    public let registerCellCallback: (UITableView) -> Void

    init(dequeueAndPresentCellCallback: @escaping (UITableView, IndexPath) -> UITableViewCell,
         registerCellCallback: @escaping (UITableView) -> Void) {
        self.dequeueAndPresentCellCallback = dequeueAndPresentCellCallback
        self.registerCellCallback = registerCellCallback
    }
}
