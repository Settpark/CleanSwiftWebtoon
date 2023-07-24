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

class WebtoonListDiffableDatasourceManager: NSObject,
                                            DiffableDatasourceManagable,
                                            UICollectionViewDelegate,
                                            UICollectionViewDelegateFlowLayout {
    
    var diffableDatasource: UICollectionViewDiffableDataSource<Section, WebtoonHome.WebtoonList.ViewModel>?
    private var snapShot: NSDiffableDataSourceSnapshot<Section, WebtoonHome.WebtoonList.ViewModel>
    
    init(inset: Int) {
        leadingTrailingInset = inset
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
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let snapShotItems: [WebtoonHome.WebtoonList.ViewModel] = snapShot.itemIdentifiers(inSection: .main)
        let targetItem: WebtoonHome.WebtoonList.ViewModel = snapShotItems[indexPath.row]
        if let webtoonCell = cell as? WebtoonListCell {
            webtoonCell.loadImage(viewModel: targetItem)
        }
    }
    
    private let minimumInteritemSpacing: CGFloat = 10
    private let leadingTrailingInset: Int
    
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

enum Section {
    case main
}
