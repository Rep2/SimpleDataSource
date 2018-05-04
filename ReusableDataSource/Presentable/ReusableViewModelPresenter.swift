public protocol ReusableViewModelPresenter {
    associatedtype ViewModel

    static var source: ReusableViewSource { get }

    func present(viewModel: ViewModel)
}

extension ReusableViewModelPresenter {
    public static var source: ReusableViewSource {
        return .class
    }
}
