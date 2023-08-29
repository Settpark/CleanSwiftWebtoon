//
//  WebtoonHomeViewController.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/16.
//

import UIKit
import WebtoonService

public class WebtoonHomeViewController: UIViewController {
    
    var router: (NSObjectProtocol & WebtoonHomeRoutingLogic)?
    
    private let mainScrollView: UIScrollView
    private let scrollInnerView: UIStackView
    private let weekDayScrollView: UIScrollView
    private let weekDayStackView: UIStackView
    private let weekDays: [WeekDayView]
    private let recommandSectionViewController: WebtoonHomeRecommandationViewController
    private let webtoonListViewController: WebtoonListParentViewController
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        mainScrollView = {
            let scrollView = UIScrollView()
            scrollView.contentInsetAdjustmentBehavior = .never
            scrollView.showsVerticalScrollIndicator = false
            scrollView.bounces = false
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()
        scrollInnerView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        weekDayScrollView = {
            let scrollView = UIScrollView()
            scrollView.bounces = false
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()
        weekDayStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.distribution = .fill
            return stackView
        }()
        weekDays = UpdateDay.allCases.map{ WeekDayView(day: $0) }
        recommandSectionViewController = .init()
        webtoonListViewController = .init(today: Date.makeUpdateDayToInt(Date.makeTodayWeekday()))
        super.init(nibName: nil, bundle: nil)
        setup()
        setupChildViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setup
    
    private func setup() {
        let viewController = self
        let router = WebtoonHomeRouter()
        viewController.router = router
        router.viewController = viewController
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        tabBarItem = UITabBarItem(title: "웹툰", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        self.view.addSubview(mainScrollView)
        mainScrollView.addSubview(scrollInnerView)
        scrollInnerView.addArrangedSubview(recommandSectionViewController.view)
        scrollInnerView.addArrangedSubview(weekDayScrollView)
        weekDayScrollView.addSubview(weekDayStackView)
        weekDays.forEach {
            weekDayStackView.addArrangedSubview($0)
            NSLayoutConstraint.activate([
                $0.widthAnchor.constraint(equalToConstant: 50)
            ])
        }
        scrollInnerView.addArrangedSubview(webtoonListViewController.view)
        
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            mainScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            scrollInnerView.topAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.topAnchor),
            scrollInnerView.bottomAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.bottomAnchor),
            scrollInnerView.leadingAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.leadingAnchor),
            scrollInnerView.trailingAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.trailingAnchor),
            scrollInnerView.widthAnchor.constraint(equalTo: mainScrollView.frameLayoutGuide.widthAnchor),
            
            recommandSectionViewController.view.heightAnchor.constraint(equalToConstant: 260),
            weekDayScrollView.heightAnchor.constraint(equalToConstant: 40),
            weekDayStackView.topAnchor.constraint(equalTo: weekDayScrollView.contentLayoutGuide.topAnchor),
            weekDayStackView.bottomAnchor.constraint(equalTo: weekDayScrollView.contentLayoutGuide.bottomAnchor),
            weekDayStackView.leadingAnchor.constraint(equalTo: weekDayScrollView.contentLayoutGuide.leadingAnchor),
            weekDayStackView.trailingAnchor.constraint(equalTo: weekDayScrollView.contentLayoutGuide.trailingAnchor),
            weekDayStackView.heightAnchor.constraint(equalTo: weekDayScrollView.frameLayoutGuide.heightAnchor),
            webtoonListViewController.view.heightAnchor.constraint(equalToConstant: 625)
        ])
    }
    
    //MARK: View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupChildViewController() {
        recommandSectionViewController.didMove(toParent: self)
        addChild(recommandSectionViewController)
        
        webtoonListViewController.didMove(toParent: self)
        addChild(webtoonListViewController)
        
        webtoonListViewController.setListener()
    }
}

extension WebtoonHomeViewController: DetailListRoutingListener {
    func routeToDetailWebtoonList(webtoonTitle: String) {
        router?.routeToDeatilListViewController(target: webtoonTitle)
    }
}
