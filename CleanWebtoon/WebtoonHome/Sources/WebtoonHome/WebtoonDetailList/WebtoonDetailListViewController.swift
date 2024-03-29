//
//  WebtoonDetailListViewController.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/21.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import CustomUtility

protocol WebtoonDetailListDisplayLogic: AnyObject {
    func displayDetailWebtoonList(viewModel: [WebtoonDetailList.DetailList.ViewModel])
    func displayDetailWebtoonView(viewModel: WebtoonDetailList.DetailTitlePart.ViewModel)
}

public class WebtoonDetailListViewController: UIViewController, WebtoonDetailListDisplayLogic {
        
    var interactor: WebtoonDetailListBusinessLogic?
    var router: (NSObjectProtocol & WebtoonDetailListRoutingLogic & WebtoonDetailListDataPassing)?
    
    // MARK: Object lifecycle
    private let decorationView: UIView
    private let thumbnailImage: UIImageView
    private let detailDescriptionView: DetailDescriptionView
    private let webtoonTitle: UILabel
    private let author: UILabel
    
    private lazy var detailListView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bounces = false
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    private var dataSource: CustomCollectionViewDatasource<DetailListSection,
                                                           WebtoonDetailList.DetailList.ViewModel,
                                                           DetailListCell>?
    private let collectionViewDelegate: UICollectionViewDelegate
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        decorationView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .red
            return view
        }()
        thumbnailImage = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "default_icon")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        detailDescriptionView = {
            let view = DetailDescriptionView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        webtoonTitle = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        author = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        collectionViewDelegate = WebtoonDetailListCollectionViewDelegate()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = WebtoonDetailListInteractor()
        let presenter = WebtoonDetailListPresenter()
        let router = WebtoonDetailListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupViews() {
        self.navigationController?.navigationBar.isHidden = false
        let backButton: UIBarButtonItem = {
            let buttonItem = UIBarButtonItem()
            buttonItem.title = ""
            buttonItem.tintColor = .black
            return buttonItem
        }()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        view.backgroundColor = .white
        
        self.view.addSubview(decorationView)
        self.view.addSubview(thumbnailImage)
        self.view.addSubview(webtoonTitle)
        self.view.addSubview(author)
        self.view.addSubview(detailDescriptionView)
        self.view.addSubview(detailListView)

        NSLayoutConstraint.activate([
            decorationView.topAnchor.constraint(equalTo: self.view.topAnchor),
            decorationView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            decorationView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),

            thumbnailImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            thumbnailImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            thumbnailImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            thumbnailImage.heightAnchor.constraint(equalToConstant: 175),

            webtoonTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            webtoonTitle.topAnchor.constraint(equalTo: self.thumbnailImage.bottomAnchor, constant: 5),
            author.leadingAnchor.constraint(equalTo: self.webtoonTitle.leadingAnchor),
            author.topAnchor.constraint(equalTo: self.webtoonTitle.bottomAnchor, constant: 5),
            detailDescriptionView.leadingAnchor.constraint(equalTo: webtoonTitle.leadingAnchor),
            detailDescriptionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            detailDescriptionView.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 10),
            detailDescriptionView.heightAnchor.constraint(equalToConstant: 180),

            decorationView.bottomAnchor.constraint(equalTo: thumbnailImage.centerYAnchor, constant: -10),

            detailListView.topAnchor.constraint(equalTo: detailDescriptionView.bottomAnchor, constant: 10),
            detailListView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            detailListView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            detailListView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(65))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setupCollectionView() {
        self.dataSource = CustomCollectionViewDatasource(collectionView: detailListView,
                                                         completion: { [weak self] cell, IndexPath, itemType in
            cell.configureView(viewModel: itemType)
            cell.routingEventlistener = self
        })
        detailListView.delegate = collectionViewDelegate
    }
    
    // MARK: View lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchWebtoonDetailList()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTabBarViewController()
    }
    
    // MARK: Do something
    
    private func showTabBarViewController() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func hiddenDecorationView() {
        decorationView.isHidden = true
    }
    
    private func showDecorationView() {
        decorationView.isHidden = false
    }
    
    func fetchWebtoonDetailList() {
        interactor?.fetchWebtoonDetailList()
    }
    
    func displayDetailWebtoonList(viewModel: [WebtoonDetailList.DetailList.ViewModel]) {
        dataSource?.updateData(seciton: .main,
                               models: viewModel)
    }
    
    func displayDetailWebtoonView(viewModel: WebtoonDetailList.DetailTitlePart.ViewModel) {
        let task = UIImage.loadImage(from: viewModel.thumbnailImage) { [weak self] image in
            guard let self = self,
                  let image = image else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.thumbnailImage.image = image
                ImageCacheManger.shared.cacheImage(forKey: viewModel.imageCacheKey, image: image) //MARK: memory leak의 원인
            }
        }
        webtoonTitle.text = viewModel.title
        author.text = viewModel.author
        detailDescriptionView.configureView(viewModel: viewModel)
        if let validCacheImage = ImageCacheManger.shared.loadCachedImage(forKey: viewModel.imageCacheKey) {
            DispatchQueue.main.async { [weak self] in
                self?.thumbnailImage.image = validCacheImage
            }
            return
        }
        task?.resume()
    }
}

extension WebtoonDetailListViewController: WebtoonBodyRoutingEventListener {
    func routeToBody(webtoonListIndex: Int) {
        router?.routeToWebtoonBody(webtoonIndex: webtoonListIndex)
    }
}
