import UIKit

open class AnyTableViewDataSource: NSObject, UITableViewDataSource {
    open var viewModels = [[AnyDequeuableTableViewCellViewModel]]()

    open var automaticallyRegisterReuseIdentifiers: Bool

    public init(automaticallyRegisterReuseIdentifiers: Bool = true) {
        self.automaticallyRegisterReuseIdentifiers = automaticallyRegisterReuseIdentifiers

        super.init()
    }

    open func present(viewModels: [[AnyDequeuableTableViewCellViewModel]], onTableView tableView: UITableView) {
        self.viewModels = viewModels

        if automaticallyRegisterReuseIdentifiers {
            viewModels
                .flatMap { $0 }
                .forEach { $0.registerCell(tableView) }
        }

        tableView.reloadData()
    }

    open func present(viewModels: [AnyDequeuableTableViewCellViewModel], onTableView tableView: UITableView) {
        present(viewModels: [viewModels], onTableView: tableView)
    }
}

extension AnyTableViewDataSource {
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModels[indexPath.section][indexPath.row].dequeueAndPresentCell(tableView, indexPath)
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels[section].count
    }

    open func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels.count
    }
}
