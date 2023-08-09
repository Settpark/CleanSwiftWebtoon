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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private let dataSource: WebtoonListDatasource
    
    private let index: Int
    
    init(index: Int) {
        self.index = index
        dataSource = WebtoonListDatasource()
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
        setupDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                       subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setupDataSource() {
        dataSource.bindingCollectionView(webtoonListCollectionView)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.random()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(index)"
        label.font = .systemFont(ofSize: 15)
        self.view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        view.addSubview(webtoonListCollectionView)
        NSLayoutConstraint.activate([
            webtoonListCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            webtoonListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webtoonListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webtoonListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func updateDatasource(models: [WebtoonHomeModels.WebtoonModels.ViewModel]) {
        self.dataSource.updateData(models: models)
    }
}

extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
