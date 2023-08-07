//
//  DataSourceSetup.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/03.
//

import UIKit

protocol DatasourceDependency {
    var datasource: UICollectionViewDiffableDataSource<WebtoonHomeTab.WebtoonHomeTabSection, WebtoonHomeTab.WebtoonModel.ViewModel> { get }
}

class WebtoonHomeDatasource: DatasourceDependency {
    
    private let weekDataModel: [String] = ["신작", "매일+", "월", "화", "수", "목", "금", "토", "일", "완결"]
    var datasource: UICollectionViewDiffableDataSource<WebtoonHomeTab.WebtoonHomeTabSection, WebtoonHomeTab.WebtoonModel.ViewModel>
    
    init(datasourceTargetCollectionView: UICollectionView) {
        self.datasource = UICollectionViewDiffableDataSource<WebtoonHomeTab.WebtoonHomeTabSection, WebtoonHomeTab.WebtoonModel.ViewModel>(
            collectionView: datasourceTargetCollectionView,
            cellProvider: { collectionView, indexPath, viewModel in
                return collectionView.dequeueConfiguredReusableCell(using: WebtoonHomeDatasource.makeCellConfiguration(section: indexPath.section),
                                                                    for: indexPath,
                                                                    item: viewModel)
            }
        )
    }
    
    private static func makeCellConfiguration<T: UICollectionViewCell>(section: Int) -> UICollectionView.CellRegistration<T, WebtoonHomeTab.WebtoonModel.ViewModel> {
        switch WebtoonHomeTab.WebtoonHomeTabSection(rawValue: section) {
        case .recommand:
            return UICollectionView.CellRegistration<T, WebtoonHomeTab.WebtoonModel.ViewModel> { cell, indexPath, itemIdentifier in
                if let cell = cell as? WebtoonListCell {
                    cell.configureCell(viewModel: itemIdentifier)
                }
            }
        case .week:
            break
        case .webtoonList:
            break
        case .none:
            break
        }
        return UICollectionView.CellRegistration<T, WebtoonHomeTab.WebtoonModel.ViewModel> { cell, indexPath, itemIdentifier in }
    }
}
