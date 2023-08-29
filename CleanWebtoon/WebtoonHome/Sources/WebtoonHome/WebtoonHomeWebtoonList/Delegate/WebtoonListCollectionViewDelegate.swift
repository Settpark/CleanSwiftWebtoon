//
//  WebtoonListCollectionViewDelegate.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/21.
//

import UIKit

class WebtoonListCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let cell = cell as? WebtoonListCell {
            cell.loadImage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? WebtoonListCell {
            cell.routeToDetailListView()
        }
    }
}
