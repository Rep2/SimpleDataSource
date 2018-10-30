# SimpleDataSource

Simplifies data source implementation by reorganising responsibilities and using a data driven approach. Improves reusability and decreases the amount of boilerplate.

## Usage

*Note: For simplicity I'll be addressing UITableView only, but everything, including framework support, extends to UICollectionView*

Responsibilitie reorganisation starts with moving the view model presentation to the cell.

```Swift
struct MovieViewModel {
    let name: String
    let releaseYear: Int
}

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    ...
}

extension MovieTableViewCell: PresentingTableViewCell {
    func present(viewModel: MovieViewModel) {
        nameLabel.text = viewModel.name
        releaseYearLabel.text = String(viewModel.releaseYear)
    }
}
```

Next, specify the cell type that should be registered and dequeued for a particular view model. To be able to use the default implementations, ```TableViewCell.ViewModel``` must equal ```Self```.

```Swift
extension ActorViewModel: DequeuableTableViewCellViewModel {
    typealias TableViewCell = ActorTableViewCell
}
```

Instead of implementing a custom ```UITableViewDataSource```, we will use ```AnyTableViewDataSource```. We simply initialise and set it as the tableViews dataSource.

```Swift
class MovieViewController: UITableViewController {
    lazy var dataSource = SimpleTableViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
    }
}
```

Finally, map and present the data. For the view model mapping we can use the ```tableViewPresentable``` computed property.

```Swift
class MovieViewController: UITableViewController {
    ...
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
    
    func presentCellViewModels() {
        let cellViewModels = movies
            .map { movie -> [AnyDequeuableTableViewCellViewModel] in
                var movieViewModels = [movie.tableViewPresentable]

                movieViewModels.append(contentsOf: movie.actors.map { $0.tableViewPresentable })

                return movieViewModels
            }

        dataSource.present(viewModels: cellViewModels, onTableView: tableView)
    }
```

That's it! Check it out by running the demo project.

![Demo project screenshot](SimpleDataSourceDemo/DemoScreenshot.png?raw=true)

For a more detailed showcase, take a look at this [blog post](https://medium.com/p/86d83a24b620).

## Installation

### Carthage

```
github "Rep2/ReusableDataSource" ~> 0.3
```

## Detailed overview

```DequeuableTableViewCellViewModel``` protocol specifies how to register and dequeue a table view cell from a view model.

```Swift
protocol DequeuableTableViewCellViewModel {
    associatedtype TableViewCell: PresentingTableViewCell

    func dequeueReusableCell(forRowAt indexPath: IndexPath, onTableView tableView: UITableView) -> TableViewCell
    func registerTableViewCell(onTableView tableView: UITableView)
}
```

```PresentingCollectionViewCell``` protocol defines a view model type that a cell can present. It also specifies the cell source which is used during the cell registration.

```Swift
protocol PresentingCollectionViewCell {
    associatedtype ViewModel: DequeuableCollectionViewCellViewModel

    static var source: CellSource { get }

    func present(viewModel: ViewModel)
}

extension PresentingCollectionViewCell {
    static var source: CellSource {
        return .class
    }
}
```

By combining the previously defined associated types, we can provide default implementations for cell registration and dequeue, as long as ```TableViewCell``` is ```UITableViewCell```, and ```TableViewCell.ViewModel``` equals view model type that implemented the ```DequeuableTableViewCellViewModel``` protocol.

```Swift
extension DequeuableTableViewCellViewModel where TableViewCell: UITableViewCell, TableViewCell.ViewModel == Self {
    func dequeueReusableCell(forRowAt indexPath: IndexPath, onTableView tableView: UITableView) -> TableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TableViewCell

        cell.present(viewModel: self)

        return cell
    }
}

extension DequeuableTableViewCellViewModel where TableViewCell: UITableViewCell {
    func registerTableViewCell(onTableView tableView: UITableView) {
        tableView.register(cell: TableViewCell.self, reusableCellSource: TableViewCell.source)
    }
}
```

As the ```DequeuableTableViewCellViewModel``` contains an associated type, we can only use it as a generic constraint. To be able to pass it as a parameter, we need to remove the associated type using type-erasure. This is the role of ```AnyDequeuableTableViewCellViewModel```. 

```tableViewPresentable``` is a stored property of ```DequeuableTableViewCellViewModel``` that simplifes this transformation.

```Swift 
class AnyDequeuableCollectionViewCellViewModel {
    let dequeueAndPresentCell: (UICollectionView, IndexPath) -> UICollectionViewCell
    let registerCell: (UICollectionView) -> Void
}

extension DequeuableTableViewCellViewModel where TableViewCell: UITableViewCell {
    var tableViewPresentable: AnyDequeuableTableViewCellViewModel {
        return AnyDequeuableTableViewCellViewModel(
            dequeueAndPresentCell: { (tableView: UITableView, indexPath: IndexPath) -> UITableViewCell in
                return self.dequeueReusableCell(forRowAt: indexPath, onTableView: tableView)
            },
            registerCell: { (tableView: UITableView) in
                self.registerTableViewCell(onTableView: tableView)
            }
        )
    }
}
```

```SimpleTableViewDataSource``` implements the ```UITableViewDataSource``` by using the register and dequeue closures.

```Swift
class SimpleTableViewDataSource: NSObject {
    var viewModels = [[AnyDequeuableTableViewCellViewModel]]()

    var automaticallyRegisterReuseIdentifiers: Bool

    init(automaticallyRegisterReuseIdentifiers: Bool = true) {
        self.automaticallyRegisterReuseIdentifiers = automaticallyRegisterReuseIdentifiers

        super.init()
    }

    func present(viewModels: [[AnyDequeuableTableViewCellViewModel]], onTableView tableView: UITableView) {
        self.viewModels = viewModels

        if automaticallyRegisterReuseIdentifiers {
            viewModels
                .flatMap { $0 }
                .forEach { $0.registerCell(tableView) }
        }

        tableView.reloadData()
    }

    func present(viewModels: [AnyDequeuableTableViewCellViewModel], onTableView tableView: UITableView) {
        present(viewModels: [viewModels], onTableView: tableView)
    }
}

extension SimpleTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModels[indexPath.section][indexPath.row].dequeueAndPresentCell(tableView, indexPath)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels[section].count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels.count
    }
}
```

By default ```SimpleTableViewDataSource``` registers a cell each time it's presented. This means that the number of cell registrations is the same as the number of cell presentations. To remove this behavior set the ```automaticallyRegisterReuseIdentifiers``` to false.

## License

ReusableDataSource is available under the MIT license. See the LICENSE file for more info.
