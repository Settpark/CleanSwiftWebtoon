//
//  WebtoonHomeViewController.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/16.
//

import UIKit

class WebtoonHomeViewController: UIViewController {
    private let recommandSectionViewController: WebtoonHomeRecommandationViewController
    private let webtoonListViewController: WebtoonListParentViewController
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        recommandSectionViewController = .init()
        webtoonListViewController = .init(today: Date.makeUpdateDayToInt(Date.makeTodayWeekday()))
        super.init(nibName: nil, bundle: nil)
        setupChildViewController()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        title = "웹툰"
        tabBarItem = UITabBarItem(title: "웹툰", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        self.view.addSubview(recommandSectionViewController.view)
        self.view.addSubview(webtoonListViewController.view)
        
        NSLayoutConstraint.activate([
            recommandSectionViewController.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            recommandSectionViewController.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            recommandSectionViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            recommandSectionViewController.view.heightAnchor.constraint(equalToConstant: 270),
            
            webtoonListViewController.view.topAnchor.constraint(equalTo: recommandSectionViewController.view.bottomAnchor),
            webtoonListViewController.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            webtoonListViewController.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            webtoonListViewController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupChildViewController() {
        recommandSectionViewController.didMove(toParent: self)
        addChild(recommandSectionViewController)
        
        webtoonListViewController.didMove(toParent: self)
        addChild(webtoonListViewController)
    }
}
