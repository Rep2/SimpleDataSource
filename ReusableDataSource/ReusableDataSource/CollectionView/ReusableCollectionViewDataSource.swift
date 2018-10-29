import UIKit

public protocol ReusableCollectionViewDataSource: UICollectionViewDataSource {
    var viewModels: [[AnyCollectionViewPresentableViewModel]] { get set }

    var automaticallyRegisterReuseIdentifiers: Bool { get }

    func reload(viewModels: [[AnyCollectionViewPresentableViewModel]], onCollectionView collectionView: UICollectionView)
    func reload(viewModels: [AnyCollectionViewPresentableViewModel], onCollectionView collectionView: UICollectionView)
}

extension ReusableCollectionViewDataSource {
    var automaticallyRegisterReuseIdentifiers: Bool {
        return true
    }

    func reload(viewModels: [[AnyCollectionViewPresentableViewModel]], onCollectionView collectionView: UICollectionView) {
        self.viewModels = viewModels

        if automaticallyRegisterReuseIdentifiers {
            viewModels
                .flatMap { $0 }
                .forEach { $0.registerCellCallback(collectionView) }
        }

        collectionView.reloadData()
    }

    func reload(viewModels: [AnyCollectionViewPresentableViewModel], onCollectionView collectionView: UICollectionView) {
        reload(viewModels: [viewModels], onCollectionView: collectionView)
    }
}

extension ReusableCollectionViewDataSource {
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
