import UIKit

class WebtoonDetailListCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DetailListCell {
            cell.routeToBody(index: indexPath.item)
        }
    }
}
