//
//  DataSourceSetup.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/03.
//

import UIKit

public enum WebtoonListSection {
    case main
}

public enum RecommandWebtoonSection {
    case main
}

public enum DetailListSection {
    case preview
    case main
}

public class CustomCollectionViewDatasource<SectionType, ItemType, CellType> where SectionType: Hashable,
                                                                                   ItemType: Hashable,
                                                                                   CellType: UICollectionViewCell {
    
    private let datasource: UICollectionViewDiffableDataSource<SectionType, ItemType>
    
    public init(collectionView: UICollectionView,
                completion: @escaping (CellType, IndexPath, ItemType) -> Void) {
        let cellRegistration = UICollectionView.CellRegistration<CellType, ItemType> { cell, indexPath, itemIdentifier in
            completion(cell, indexPath, itemIdentifier)
        }
        datasource = UICollectionViewDiffableDataSource<SectionType, ItemType>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            })
    }
    
    public func updateData(seciton: SectionType,
                    models: [ItemType]) {
        var snapShot = NSDiffableDataSourceSnapshot<SectionType,
                                                    ItemType>()
        snapShot.appendSections([seciton])
        snapShot.appendItems(models)
        datasource.apply(snapShot, animatingDifferences: false)
    }
}
