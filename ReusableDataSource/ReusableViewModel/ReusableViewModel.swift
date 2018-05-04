public struct ReusableViewModel<Presenter: ReusablePresenter> {
    public let viewModel: Presenter.ViewModel

    public init(viewModel: Presenter.ViewModel) {
        self.viewModel = viewModel
    }
}
