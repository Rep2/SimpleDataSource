import UIKit
import SimpleDataSource

struct ActorViewModel {
    let name: String
}

extension ActorViewModel: DequeuableTableViewCellViewModel {
    typealias TableViewCell = ActorTableViewCell
}
