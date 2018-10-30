import SimpleDataSource
import UIKit

class MovieViewController: UITableViewController {
    lazy var dataSource = SimpleTableViewDataSource()

    let movies = [
        MovieViewModel(name: "Above the Law", releaseYear: 1988, actors: [
            ActorViewModel(name: "Steven Seagal"),
            ActorViewModel(name: "Pam Grier"),
            ActorViewModel(name: "Henry Silva")
            ]
        ),
        MovieViewModel(name: "Under Siege", releaseYear: 1992, actors: [
            ActorViewModel(name: "Steven Seagal"),
            ActorViewModel(name: "Gary Busey"),
            ActorViewModel(name: "Tommy Lee Jones")
            ]
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Best movies ever"

        tableView.dataSource = dataSource

        let viewModels = movies
            .map { movie -> [AnyDequeuableTableViewCellViewModel] in
                var movieViewModels = [movie.tableViewPresentable]

                movieViewModels.append(contentsOf: movie.actors.map { $0.tableViewPresentable })

                return movieViewModels
            }

        dataSource.present(viewModels: viewModels, onTableView: tableView)
    }
}
