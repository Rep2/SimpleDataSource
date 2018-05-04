import UIKit

public class ReusableCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var presentableViewModels = [[AnyCollectionViewPresentableViewModel]]()

    public func present(presentableViewModels: [[AnyCollectionViewPresentableViewModel]], on collectionView: UICollectionView) {
        self.presentableViewModels = presentableViewModels

        presentableViewModels
            .flatMap { $0 }
            .forEach { $0.registerCellCallback(collectionView) }

        collectionView.reloadData()
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return presentableViewModels[section].count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return presentableViewModels[indexPath.section][indexPath.row].dequeueAndPresentCellCallback(collectionView)
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presentableViewModels.count
    }
}
