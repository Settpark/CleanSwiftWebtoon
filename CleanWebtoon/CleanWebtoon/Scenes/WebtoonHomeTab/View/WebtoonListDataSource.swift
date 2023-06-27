//
//  WebtoonListDataSource.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/27.
//

import UIKit

class WebtoonListDataSource: NSObject, UICollectionViewDataSource {
    private var webtoonDataSource: [WebtoonHome.WebtoonList.ViewModel]
    
    override init() {
        webtoonDataSource = []
    }
    
    func update(dataSource: [WebtoonHome.WebtoonList.ViewModel]) {
        self.webtoonDataSource = dataSource
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return webtoonDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WebtoonListCell.identifier, for: indexPath) as? WebtoonListCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(viewModel: webtoonDataSource[indexPath.item])
        return cell
    }
}
