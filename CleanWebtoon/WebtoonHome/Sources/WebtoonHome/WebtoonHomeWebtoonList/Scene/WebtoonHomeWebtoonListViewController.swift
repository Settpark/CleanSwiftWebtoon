//
//  WebtoonHomeWebtoonListViewController.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/16.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import CustomUtility
import WebtoonService

protocol DetailListRoutingListenerDependency {
    func routeToDetailListViewController(target: String)
}

public protocol WebtoonHomeWebtoonListDisplayLogic: AnyObject {
    func displayWebtoonList(viewModel: [WebtoonHomeWebtoonList.WebtoonModels.ViewModel])
}

public class WebtoonHomeWebtoonListViewController: UIViewController, WebtoonHomeWebtoonListDisplayLogic {
    public weak var detailListRouter: DetailListRoutingListener?
    private var interactor: WebtoonHomeWebtoonListBusinessLogic?
    
    // MARK: Object lifecycle
    private lazy var webtoonListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.bounces = false
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    private var dataSource: CustomCollectionViewDatasource<WebtoonListSection,
                                                           WebtoonHomeWebtoonList.WebtoonModels.ViewModel,
                                                           WebtoonListCell>?
    private var targetDay: UpdateDay
    private let webtoonCollectionViewScrollDelegate: UICollectionViewDelegate
    
    public init(targetDay: UpdateDay, interactor: WebtoonHomeWebtoonListBusinessLogic) {
        self.targetDay = targetDay
        self.webtoonCollectionViewScrollDelegate = WebtoonListCollectionViewDelegate()
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        setup()
        setupViews()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let presenter = WebtoonHomeWebtoonListPresenter()
        if let interactor = interactor as? WebtoonHomeWebtoonListInteractor {
            interactor.presenter = presenter
        }
        presenter.viewController = viewController
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
    
    private func setupCollectionView() {
        self.dataSource = .init(collectionView: webtoonListCollectionView, completion: { cell, IndexPath, itemType in
            cell.configureCell(viewModel: itemType)
            cell.routingListener = self
        })
        self.webtoonListCollectionView.delegate = webtoonCollectionViewScrollDelegate
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(webtoonListCollectionView)
        NSLayoutConstraint.activate([
            webtoonListCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            webtoonListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            webtoonListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            webtoonListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: View lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        fetchWebtoonList()
    }
    
    // MARK: Do something
    
    func fetchWebtoonList() {
        let request = WebtoonHomeWebtoonList.WebtoonModels.Request(page: 0,
                                                                   perPage: 300,
                                                                   service: .naver,
                                                                   updateDay: targetDay)
        interactor?.fetchWebtoonList(request: request)
    }
    
    public func displayWebtoonList(viewModel: [WebtoonHomeWebtoonList.WebtoonModels.ViewModel]) {
        self.dataSource?.updateData(seciton: .main, models: viewModel)
    }
}

extension WebtoonHomeWebtoonListViewController: DetailListRoutingListener {
    public func routeToDetailWebtoonList(webtoonTitle: String) {
        detailListRouter?.routeToDetailWebtoonList(webtoonTitle: webtoonTitle)
    }
}
