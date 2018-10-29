import UIKit

open class AnyCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    open var viewModels = [[AnyDequeuableCollectionViewCellViewModel]]()

    open var automaticallyRegisterReuseIdentifiers: Bool

    public init(automaticallyRegisterReuseIdentifiers: Bool = true) {
        self.automaticallyRegisterReuseIdentifiers = automaticallyRegisterReuseIdentifiers

        super.init()
    }

    open func present(viewModels: [[AnyDequeuableCollectionViewCellViewModel]], onCollectionView collectionView: UICollectionView) {
        self.viewModels = viewModels

        if automaticallyRegisterReuseIdentifiers {
            viewModels
                .flatMap { $0 }
                .forEach { $0.registerCell(collectionView) }
        }

        collectionView.reloadData()
    }

    open func present(viewModels: [AnyDequeuableCollectionViewCellViewModel], onCollectionView collectionView: UICollectionView) {
        present(viewModels: [viewModels], onCollectionView: collectionView)
    }
}

extension AnyCollectionViewDataSource {
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModels[indexPath.section][indexPath.row].dequeueAndPresentCell(collectionView, indexPath)
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels[section].count
    }

    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModels.count
    }
}
