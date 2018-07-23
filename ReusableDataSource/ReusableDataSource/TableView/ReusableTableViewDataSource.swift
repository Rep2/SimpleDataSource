import UIKit

open class ReusableTableViewDataSource: NSObject {
    var presentableViewModels = [[AnyTableViewPresentableViewModel]]()

    public var automaticallyRegisterReuseIdentifiers: Bool

    public init(automaticallyRegisterReuseIdentifiers: Bool = true) {
        self.automaticallyRegisterReuseIdentifiers = automaticallyRegisterReuseIdentifiers
    }

    public func present(presentableViewModels: [AnyTableViewPresentableViewModel], on tableView: UITableView) {
        present(presentableViewModels: [presentableViewModels], on: tableView)
    }

    public func present(presentableViewModels: [[AnyTableViewPresentableViewModel]], on tableView: UITableView) {
        self.presentableViewModels = presentableViewModels

        if automaticallyRegisterReuseIdentifiers {
            presentableViewModels
                .flatMap { $0 }
                .forEach { $0.registerCellCallback(tableView) }
        }

        tableView.reloadData()
    }
}

extension ReusableTableViewDataSource: UITableViewDataSource {
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presentableViewModels[indexPath.section][indexPath.row].dequeueAndPresentCellCallback(tableView, indexPath)
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentableViewModels[section].count
    }

    open func numberOfSections(in tableView: UITableView) -> Int {
        return presentableViewModels.count
    }
}
