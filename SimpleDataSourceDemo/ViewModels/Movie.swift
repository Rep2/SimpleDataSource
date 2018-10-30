import UIKit
import SimpleDataSource

struct Movie {
    let name: String
    let releaseYear: Int

    let actors: [Actor]
}

extension Movie: DequeuableTableViewCellViewModel {
    typealias TableViewCell = MovieTableViewCell
}
