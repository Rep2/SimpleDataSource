import UIKit

open class ReusableCollectionViewDataSource: NSObject {
    var presentableViewModels = [[AnyCollectionViewPresentableViewModel]]()

    public var automaticallyRegisterReuseIdentifiers: Bool

    public init(automaticallyRegisterReuseIdentifiers: Bool = true) {
        self.automaticallyRegisterReuseIdentifiers = automaticallyRegisterReuseIdentifiers
    }

    public func present(presentableViewModels: [AnyCollectionViewPresentableViewModel], on collectionView: UICollectionView) {
        present(presentableViewModels: [presentableViewModels], on: collectionView)
    }

    public func present(presentableViewModels: [[AnyCollectionViewPresentableViewModel]], on collectionView: UICollectionView) {
        self.presentableViewModels = presentableViewModels

        if automaticallyRegisterReuseIdentifiers {
            presentableViewModels
                .flatMap { $0 }
                .forEach { $0.registerCellCallback(collectionView) }
        }

        collectionView.reloadData()
    }
}

extension ReusableCollectionViewDataSource: UICollectionViewDataSource {
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return presentableViewModels[section].count
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return presentableViewModels[indexPath.section][indexPath.row].dequeueAndPresentCellCallback(collectionView, indexPath)
    }

    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presentableViewModels.count
    }
}
