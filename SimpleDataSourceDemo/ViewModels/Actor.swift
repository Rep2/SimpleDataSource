import UIKit
import SimpleDataSource

struct Actor {
    let name: String
}

extension Actor: DequeuableTableViewCellViewModel {
    typealias TableViewCell = ActorTableViewCell
}
