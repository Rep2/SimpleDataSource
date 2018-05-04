public struct PresentableViewModel<Presenter: ReusableViewModelPresenter> {
    public let viewModel: Presenter.ViewModel

    public init(viewModel: Presenter.ViewModel) {
        self.viewModel = viewModel
    }
}
