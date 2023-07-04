//
//  WebtoonListLayout.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/27.
//

import UIKit

class WebtoonListLayout: NSObject, UICollectionViewDelegateFlowLayout {
    
    private let minimumInteritemSpacing: CGFloat = 10
    private let leadingTrailingInset: Int
    
    init(inset: Int) {
        leadingTrailingInset = inset
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let itemWidth = (collectionViewWidth - (2 * minimumInteritemSpacing) - (CGFloat(leadingTrailingInset) * 2)) / 3
        return CGSize(width: itemWidth, height: itemWidth / 100 * 170)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
}
