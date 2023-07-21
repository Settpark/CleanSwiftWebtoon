//
//  WebtoonListDiffableDatasourceManager.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/07/10.
//

import UIKit

protocol DiffableDatasourceManagable {
    var diffableDatasource: UICollectionViewDiffableDataSource<Section, WebtoonHome.WebtoonList.ViewModel>? { get }
    func updateCollectionViewData(newData: [WebtoonHome.WebtoonList.ViewModel])
    func bindingDatasource(collectionView: UICollectionView)
}

class WebtoonListDiffableDatasourceManager: DiffableDatasourceManagable {
    var diffableDatasource: UICollectionViewDiffableDataSource<Section, WebtoonHome.WebtoonList.ViewModel>?
    private var snapShot: NSDiffableDataSourceSnapshot<Section, WebtoonHome.WebtoonList.ViewModel>
    
    init() {
        self.snapShot = NSDiffableDataSourceSnapshot<Section, WebtoonHome.WebtoonList.ViewModel>()
        snapShot.appendSections([.main])
    }
    
    func bindingDatasource(collectionView: UICollectionView) {
        self.diffableDatasource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                                     cellProvider: { (collectionView: UICollectionView,
                                                                                      indexPath: IndexPath,
                                                                                      itemIdentifier: WebtoonHome.WebtoonList.ViewModel) in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WebtoonListCell.identifier, for: indexPath) as? WebtoonListCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(viewModel: itemIdentifier)
            return cell
        })
    }
    
    func updateCollectionViewData(newData: [WebtoonHome.WebtoonList.ViewModel]) {
        snapShot.appendItems(newData)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.diffableDatasource?.apply(self.snapShot, animatingDifferences: false)
        }
    }
}

enum Section {
    case main
}
