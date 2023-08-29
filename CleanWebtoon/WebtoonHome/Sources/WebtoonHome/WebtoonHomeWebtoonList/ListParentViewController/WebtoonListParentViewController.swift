import UIKit
import WebtoonService

protocol PageChangeEventListener: AnyObject {
    func setupView(_ view: UIView)
    func pageChange(page: Int)
    func sendCurrentCollectionView(_ collectionView: UICollectionView)
}

class WebtoonListParentViewController: UIPageViewController {
    private var contentViewControllerIdx: Int
    private let listViewControllers: [WebtoonHomeWebtoonListViewController]
    
    init(today: Int, pageChangeEventListener: PageChangeEventListener? = nil) {
        self.contentViewControllerIdx = today
        listViewControllers = UpdateDay.allCases.map({ WebtoonHomeWebtoonListViewController(targetDay: $0) })
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        setupViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewController() {
        view.translatesAutoresizingMaskIntoConstraints = false
        let initialViewController = listViewControllers[contentViewControllerIdx]
        setViewControllers([initialViewController], direction: .forward, animated: true)
        dataSource = self
    }
    
    private func findCurrentViewController() -> UICollectionView? {
        return listViewControllers[contentViewControllerIdx].view.subviews.compactMap({ return $0 as? UICollectionView }).first
    }
    
    func setListener() {
        if let parentViewController = self.parent as? DetailListRoutingListener {
            listViewControllers.forEach { $0.detailListRouter = parentViewController }
        }
    }
}

extension WebtoonListParentViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? WebtoonHomeWebtoonListViewController,
              let index = listViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        contentViewControllerIdx = previousIndex
        return listViewControllers[contentViewControllerIdx]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? WebtoonHomeWebtoonListViewController,
              let index = listViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = index + 1
        if nextIndex > UpdateDay.allCases.count - 1 {
            return nil
        }
        contentViewControllerIdx = nextIndex
        return listViewControllers[contentViewControllerIdx]
    }
}
