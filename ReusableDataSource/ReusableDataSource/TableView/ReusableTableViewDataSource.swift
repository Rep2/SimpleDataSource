import UIKit

public protocol ReusableTableViewDataSource: UITableViewDataSource {
    var viewModels: [[AnyTableViewPresentableViewModel]] { get set }

    var automaticallyRegisterReuseIdentifiers: Bool { get }

    func reload(viewModels: [[AnyTableViewPresentableViewModel]], onTableView tableView: UITableView)
    func reload(viewModels: [AnyTableViewPresentableViewModel], onTableView tableView: UITableView)
}

extension ReusableTableViewDataSource {
    var automaticallyRegisterReuseIdentifiers: Bool {
        return true
    }

    func reload(viewModels: [[AnyTableViewPresentableViewModel]], onTableView tableView: UITableView) {
        self.viewModels = viewModels

        if automaticallyRegisterReuseIdentifiers {
            viewModels
                .flatMap { $0 }
                .forEach { $0.registerCellCallback(tableView) }
        }

        tableView.reloadData()
    }

    func reload(viewModels: [AnyTableViewPresentableViewModel], onTableView tableView: UITableView) {
        reload(viewModels: [viewModels], onTableView: tableView)
    }
}

extension ReusableTableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModels[indexPath.section][indexPath.row].dequeueAndPresentCellCallback(tableView, indexPath)
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels[section].count
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels.count
    }
}
