import UIKit
import AnyDataSource

struct Actor {
    let name: String
}

extension Actor: DequeuableTableViewCellViewModel {
    typealias TableViewCell = ActorTableViewCell
}
