import UIKit

public protocol DequeueableTableViewDataSource: UITableViewDataSource {
    var viewModels: [[AnyDequeuableTableViewCellViewModel]] { get set }

    var automaticallyRegisterReuseIdentifiers: Bool { get }

    func reload(viewModels: [[AnyDequeuableTableViewCellViewModel]], onTableView tableView: UITableView)
    func reload(viewModels: [AnyDequeuableTableViewCellViewModel], onTableView tableView: UITableView)
}

extension DequeueableTableViewDataSource {
    var automaticallyRegisterReuseIdentifiers: Bool {
        return true
    }

    func reload(viewModels: [[AnyDequeuableTableViewCellViewModel]], onTableView tableView: UITableView) {
        self.viewModels = viewModels

        if automaticallyRegisterReuseIdentifiers {
            viewModels
                .flatMap { $0 }
                .forEach { $0.registerCellCallback(tableView) }
        }

        tableView.reloadData()
    }

    func reload(viewModels: [AnyDequeuableTableViewCellViewModel], onTableView tableView: UITableView) {
        reload(viewModels: [viewModels], onTableView: tableView)
    }
}

extension DequeueableTableViewDataSource {
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
