//
//  WebtoonListViewController.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/09.
//

import UIKit

class WebtoonListViewController: UIViewController {
    private lazy var webtoonListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.bounces = false
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private let dataSource: WebtoonListDatasource
    
    init() {
        dataSource = WebtoonListDatasource()
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
        setupDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.333),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.55))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setupDataSource() {
        dataSource.bindingCollectionView(webtoonListCollectionView)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(webtoonListCollectionView)
        NSLayoutConstraint.activate([
            webtoonListCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            webtoonListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            webtoonListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            webtoonListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func updateDatasource(models: [WebtoonHomeModels.WebtoonModels.ViewModel]) {
        self.dataSource.updateData(models: models)
    }
}
