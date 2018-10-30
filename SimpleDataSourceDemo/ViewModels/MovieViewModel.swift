import UIKit
import SimpleDataSource

struct MovieViewModel {
    let name: String
    let releaseYear: Int

    let actors: [ActorViewModel]
}

extension MovieViewModel: DequeuableTableViewCellViewModel {
    typealias TableViewCell = MovieTableViewCell
}
