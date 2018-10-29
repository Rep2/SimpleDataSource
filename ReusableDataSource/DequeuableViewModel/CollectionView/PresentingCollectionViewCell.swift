import CellSource

protocol PresentingCollectionViewCell {
    associatedtype ViewModel: DequeuableCollectionViewCellViewModel

    static var source: CellSource { get }

    func present(viewModel: ViewModel)
}
