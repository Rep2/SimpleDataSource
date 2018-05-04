public protocol ReusablePresenter {
    associatedtype ViewModel

    static var source: ReusablePresenterSource { get }

    func present(viewModel: ViewModel)
}

extension ReusablePresenter {
    public static var source: ReusablePresenterSource {
        return .class
    }
}
