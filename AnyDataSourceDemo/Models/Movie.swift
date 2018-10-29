import UIKit
import AnyDataSource

struct Movie {
    let name: String
    let releaseYear: Int

    let actors: [Actor]
}

extension Movie: DequeuableTableViewCellViewModel {
    typealias TableViewCell = MovieTableViewCell
}
