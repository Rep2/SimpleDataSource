import UIKit

public protocol DequeueableCollectionViewDataSource: UICollectionViewDataSource {
    var viewModels: [[AnyDequeuableCollectionViewCellViewModel]] { get set }

    var automaticallyRegisterReuseIdentifiers: Bool { get }

    func reload(viewModels: [[AnyDequeuableCollectionViewCellViewModel]], onCollectionView collectionView: UICollectionView)
    func reload(viewModels: [AnyDequeuableCollectionViewCellViewModel], onCollectionView collectionView: UICollectionView)
}

extension DequeueableCollectionViewDataSource {
    var automaticallyRegisterReuseIdentifiers: Bool {
        return true
    }

    func reload(viewModels: [[AnyDequeuableCollectionViewCellViewModel]], onCollectionView collectionView: UICollectionView) {
        self.viewModels = viewModels

        if automaticallyRegisterReuseIdentifiers {
            viewModels
                .flatMap { $0 }
                .forEach { $0.registerCellCallback(collectionView) }
        }

        collectionView.reloadData()
    }

    func reload(viewModels: [AnyDequeuableCollectionViewCellViewModel], onCollectionView collectionView: UICollectionView) {
        reload(viewModels: [viewModels], onCollectionView: collectionView)
    }
}

extension DequeueableCollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModels[indexPath.section][indexPath.row].dequeueAndPresentCellCallback(collectionView, indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels[section].count
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModels.count
    }
}
