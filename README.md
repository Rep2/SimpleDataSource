# ReusableDataSource

Never again write a custom UITableView or UICollectionView data source. **Disclamer**: not really, but this is a good start.

## Implementation

Implement ```ReusablePresenter``` protocol on a reusable view.

```Swift
class TextTableViewCell: UITableViewCell, ReusablePresenter {
    func present(viewModel: String) {
        textLabel?.text = viewModel
    }
}
```

Create view models and specify presenter types using ```ReusableViewModel``` struct.

```Swift
let viewModels = [
    ReusableViewModel<TextTableViewCell>(viewModel: "Cell 1").anyPresentable,
    ReusableViewModel<TextTableViewCell>(viewModel: "Cell 2").anyPresentable,
    ReusableViewModel<ImageTextTableViewCell>(
        viewModel: ImageTextTableViewCellViewModel(
            textViewModel: "Cell 3", 
            imageViewModel: #imageLiteral(resourceName: "filter")
        )
    ).anyPresentable,
    ReusableViewModel<TextTableViewCell>(viewModel: "Cell 2").anyPresentable
]
```

Create a ```ReusableTableViewDataSource``` and present the view models.

```Swift
let dataSource = ReusableTableViewDataSource()

tableView.dataSource = dataSource

dataSource.present(presentableViewModels: reusableViewModels, on: tableView)
```

That's it! The reusable data source manages the cell creation and data presentation. Check it out by running the demo project.

![Demo project](https://image.ibb.co/g9BT3n/Screen_Shot_2018_05_04_at_23_51_30.png)

## Installation

### Carthage

```
github "Rep2/ReusableDataSource" ~> 0.1
```

## Detailed overview

```ReusablePresenter``` defines a view model type that the reusable view can present.

```Swift
protocol ReusablePresenter {
    associatedtype ViewModel

    static var source: ReusablePresenterSource { get }

    func present(viewModel: ViewModel)
}
```

To satisfy this protocol all that is needed is to implement ```present(viewModel: ViewModel)``` function. ```associatedtype``` is inferred from the function. 

```source``` value determines how the reusable view is created. It's default value is ```class```. Ignore it for now.

```Swift
enum ReusablePresenterSource {
    case nib
    case `class`
    case storyboard
}
```

```ReusableViewModel``` connects the presenter and the view model that the presenter knows how to present.

```Swift
struct ReusableViewModel<Presenter: ReusablePresenter> {
    let viewModel: Presenter.ViewModel

    init(viewModel: Presenter.ViewModel) {
        self.viewModel = viewModel
    }
}
```

Simply create it by specifying ```ReusablePresenter``` type and passing the associated ```ViewModel```.

```Swift
ReusableViewModel<TextTableViewCell>(viewModel: "Cell 1")
```

```ReusableTableViewDataSource``` and ```ReusableCollectionViewDataSource``` do the hard work. Initialize and set them as ```UITableView``` or ```UICollectionView``` data source.

```Swift
let dataSource = ReusableTableViewDataSource()

tableView.dataSource = dataSource
```

To be able to mix and match different view models we need to do something called ```Type erasure```. Take a look at this article to get the gist of it [Swift: Attempting to Understand Type Erasure](https://www.natashatherobot.com/swift-type-erasure/).

Basically, we need to remove the generic part of a ```ReusableViewModel``` to be able to put it into an array.

Generic part removal is done by ```AnyTableViewPresentableViewModel``` and ```AnyCollectionViewPresentableViewModel``` for ```UITableViewCell``` and ```UICollectionViewCell``` respectively. The process is simmilar to how Swift Stdlib handles ```Type erasure```. I got the motivation from [Type-erasure in Stdlib](http://robnapier.net/type-erasure-in-stdlib).

```Swift
class AnyTableViewPresentableViewModel {
    let dequeueAndPresentCellCallback: (UITableView) -> UITableViewCell
    let registerCellCallback: (UITableView) -> Void

    init<Presenter: ReusablePresenter>(base: ReusableViewModel<Presenter>) where Presenter: UITableViewCell {
        self.dequeueAndPresentCellCallback = { (tableView: UITableView) -> UITableViewCell in
            tableView.dequeueAndPresent(presentableViewModel: base, for: IndexPath(item: 0, section: 0))
        }

        self.registerCellCallback = { (tableView: UITableView) in
            tableView.register(cell: Presenter.self, reusableCellSource: Presenter.source)
        }
    }
}
```

They remove the generic part of a ```ReusableViewModel``` keeping the information we need -> how to register and dequeue the cell.

Property ```anyPresentable``` of ```ReusableViewModel``` can be used to simplify the process.

```Swift
extension ReusableViewModel where Presenter: UITableViewCell {
    var anyPresentable: AnyTableViewPresentableViewModel {
        return AnyTableViewPresentableViewModel(base: self)
    }
}

extension ReusableViewModel where Presenter: UICollectionViewCell {
    var anyPresentable: AnyCollectionViewPresentableViewModel {
        return AnyCollectionViewPresentableViewModel(base: self)
    }
}
```

Finally, pass the ```Type erased``` view models to the reusable data source.

```Swift
dataSource.present(presentableViewModels: viewModels, on: tableView)
```

Reusable data sources use the ```PresentableViewModel``` dequeue method to create the cell of a proper type and present the view model.

```Swift
extension UITableView {
    /**
     Returns a "cell" on which `presentableViewModel` was presented.

     - Important: Causes the app to crashes with `NSInternalInconsistencyException` if the `PresentingCell` type isn't previously registered.
     */
    func dequeueAndPresent<Presenter: ReusablePresenter>(presentableViewModel: ReusableViewModel<Presenter>, for indexPath: IndexPath) -> Presenter
        where Presenter: UITableViewCell {
        let cell = dequeueReusableCell(for: indexPath) as Presenter

        cell.present(viewModel: presentableViewModel.viewModel)

        return cell
    }
    
    /**
     Registers a reusable "cell" using `CustomStringConvertible` as the reuese identifier.

     - Important: Call before `dequeueReusableCell(for:)` to avoid `NSInternalInconsistencyException`.
     */
    public func register<T: UITableViewCell>(cell: T.Type, reusableCellSource: ReusablePresenterSource) {
        switch reusableCellSource {
        case .nib:
            register(UINib(nibName: String(describing: cell), bundle: nil), forCellReuseIdentifier: String(describing: cell))
        case .class, .storyboard:
            register(T.self, forCellReuseIdentifier: String(describing: cell.self))
        }
    }

    /**
     Returns a "cell" of a given type using `CustomStringConvertible` as the reuese identifier.

     - Important: Force unwraps the "cell". Causes the app to crashes with `NSInternalInconsistencyException` if the cell type isn't previously registered.
     */
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(for: indexPath)!
    }

    /**
     Returns an optional "cell" of a given type using `CustomStringConvertible` as the reuese identifier.

     - Important: Causes the app to crashes with `NSInternalInconsistencyException` if the cell type isn't previously registered.
     */
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T
    }
}
```

This is also where the ```ReusablePresenterSource``` comes into play. Data source automatically registers ```reuseIdentifier``` based on ```ReusablePresenter.source``` property. To disable this behavior set data sources ```automaticallyRegisterReuseIdentifiers``` to ```fasle```.

## License

ReusableDataSource is available under the MIT license. See the LICENSE file for more info.
