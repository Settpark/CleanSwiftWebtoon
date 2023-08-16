import UIKit

protocol PageChangeEventListener: AnyObject {
    func setupView(_ view: UIView)
    func pageChange(page: Int)
    func sendCurrentCollectionView(_ collectionView: UICollectionView)
}

class WebtoonListParentViewController: UIPageViewController {
    private var contentViewControllerIdx: Int
    private let listViewControllers: [WebtoonListViewController]
    
    init(today: Int, pageChangeEventListener: PageChangeEventListener? = nil) {
        self.contentViewControllerIdx = today
        listViewControllers = (0..<10).map({ _ in return WebtoonListViewController()})
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
    
    func updateCollectionView(data: [WebtoonHomeModels.WebtoonModels.ViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            let currentViewController = self.listViewControllers[self.contentViewControllerIdx]
            currentViewController.updateDatasource(models: data)
        }
    }
}

extension WebtoonListParentViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? WebtoonListViewController,
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
        guard let viewController = viewController as? WebtoonListViewController,
              let index = listViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = index + 1
        if nextIndex > 9 {
            return nil
        }
        contentViewControllerIdx = nextIndex
        return listViewControllers[contentViewControllerIdx]
    }
}
