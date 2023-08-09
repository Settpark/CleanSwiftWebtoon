import UIKit

protocol PageChangeEventListener: AnyObject {
    func setupView(_ view: UIView)
    func pageChange(page: Int)
}

class WebtoonListParentViewController: UIPageViewController {
    private weak var pagechangeEventListener: PageChangeEventListener?
    private var contentViewControllerIdx: Int
    private let listViewControllers: [WebtoonListViewController]
    
    init(today: Int, pageChangeEventListener: PageChangeEventListener? = nil) {
        self.pagechangeEventListener = pageChangeEventListener
        self.contentViewControllerIdx = today
        listViewControllers = [WebtoonListViewController(index: 1), WebtoonListViewController(index: 2), WebtoonListViewController(index: 3),
                               WebtoonListViewController(index: 4), WebtoonListViewController(index: 5), WebtoonListViewController(index: 6),
                               WebtoonListViewController(index: 7), WebtoonListViewController(index: 8), WebtoonListViewController(index: 9),
                               WebtoonListViewController(index: 10)]
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        setupViewController(at: today)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setListener(_ listener: PageChangeEventListener) {
        self.pagechangeEventListener = listener
        self.pagechangeEventListener?.setupView(self.view)
    }
    
    private func setupViewController(at index: Int) {
        let initialViewController = listViewControllers[index]
        setViewControllers([initialViewController], direction: .forward, animated: true)
        self.dataSource = self
    }
    
    func updateCollectionView(data: [WebtoonHomeModels.WebtoonModels.ViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            let currentViewController = listViewControllers[contentViewControllerIdx]
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
        print("previousIndex ==", previousIndex)
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
        print("nextIndex ==", nextIndex)
        contentViewControllerIdx = nextIndex
        return listViewControllers[contentViewControllerIdx]
    }
}