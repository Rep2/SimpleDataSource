public protocol PresentingTableViewCell {
    associatedtype ViewModel: DequeuableTableViewCellViewModel

    static var source: CellSource { get }

    func present(viewModel: ViewModel)
}

extension PresentingTableViewCell {
    public static var source: CellSource {
        return .class
    }
}
