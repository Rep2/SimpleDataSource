import CellSource

protocol PresentingTableViewCell {
    associatedtype ViewModel: DequeuableTableViewCellViewModel

    static var source: CellSource { get }

    func present(viewModel: ViewModel)
}
