//
//  HomeTabViewController.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/07/27.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomeTabDisplayLogic: AnyObject {
    func displaySomething(viewModel: WebtoonHomeTab.WebtoonModel.ViewModel)
}

class HomeTabViewController: UIViewController, HomeTabDisplayLogic {
    var interactor: HomeTabBusinessLogic?
    var router: (NSObjectProtocol & HomeTabRoutingLogic & HomeTabDataPassing)?
    
    // MARK: Object lifecycle
    private lazy var webtoonCollectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private lazy var WebtoonCollectionDataSource: WebtoonHomeDatasource = WebtoonHomeDatasource(datasourceTargetCollectionView: webtoonCollectionView)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = HomeTabInteractor()
        let presenter = HomeTabPresenter()
        let router = HomeTabRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        title = "웹툰"
        tabBarItem = UITabBarItem(title: "웹툰", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        self.view.addSubview(webtoonCollectionView)
        
        NSLayoutConstraint.activate([
            webtoonCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            webtoonCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            webtoonCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            webtoonCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionProvider, configuration) -> NSCollectionLayoutSection? in
            let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                     heightDimension: .fractionalWidth(0.3)))
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                                  heightDimension: .fractionalHeight(0.4)),
                subitems: [leadingItem])
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = .groupPaging

            return section
        }
        return layout
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething() {
        let request = WebtoonHomeTab.WebtoonModel.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: WebtoonHomeTab.WebtoonModel.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}