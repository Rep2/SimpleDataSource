import CellSource

public protocol PresentingCollectionViewCell {
    associatedtype ViewModel: DequeuableCollectionViewCellViewModel

    static var source: CellSource { get }

    func present(viewModel: ViewModel)
}

extension PresentingCollectionViewCell {
    public static var source: CellSource {
        return .class
    }
}
