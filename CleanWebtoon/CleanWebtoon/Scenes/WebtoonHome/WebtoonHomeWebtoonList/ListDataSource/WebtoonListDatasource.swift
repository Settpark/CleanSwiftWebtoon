//
//  DataSourceSetup.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/03.
//

import UIKit

protocol DataSourceDependency {
    var datasource: UICollectionViewDiffableDataSource<WebtoonListDatasource.Section, WebtoonHomeWebtoonList.WebtoonModels.ViewModel>? { get }
}

class WebtoonListDatasource: DataSourceDependency {
    enum Section {
        case main
    }
    
    var datasource: UICollectionViewDiffableDataSource<WebtoonListDatasource.Section, WebtoonHomeWebtoonList.WebtoonModels.ViewModel>?
    
    func bindingCollectionView(_ collectionView: UICollectionView) {
        let cellRegistration = makeCellRegistration()
        self.datasource = UICollectionViewDiffableDataSource<WebtoonListDatasource.Section, WebtoonHomeWebtoonList.WebtoonModels.ViewModel>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, viewModel in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: viewModel)
            }
        )
    }
    
    func updateData(models: [WebtoonHomeWebtoonList.WebtoonModels.ViewModel]) {
        var snapShot = NSDiffableDataSourceSnapshot<WebtoonListDatasource.Section,
                                                    WebtoonHomeWebtoonList.WebtoonModels.ViewModel>()
        snapShot.appendSections([.main])
        snapShot.appendItems(models)
        datasource?.apply(snapShot, animatingDifferences: false)
    }
    
    private func makeCellRegistration() -> UICollectionView.CellRegistration<WebtoonListCell, WebtoonHomeWebtoonList.WebtoonModels.ViewModel> {
        return UICollectionView.CellRegistration<WebtoonListCell, WebtoonHomeWebtoonList.WebtoonModels.ViewModel> { cell, indexPath, itemIdentifier in
            cell.configureCell(viewModel: itemIdentifier)
        }
    }
}
