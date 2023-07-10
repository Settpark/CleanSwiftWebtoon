//
//  ScrollDelegate.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/07/04.
//

import UIKit

enum ScrollDirection {
    case up
    case down
    case left
    case right
    case none
}

protocol ScrollViewPositionChecker: AnyObject {
    func fetchWebtoons(nextPostion: CGFloat, scrollDirection: ScrollDirection)
    func updateCurrentUpdateday(offset: CGFloat)
}

class WebtoonListScrollDelegate: NSObject, UIScrollViewDelegate {
    weak var listner: ScrollViewPositionChecker?
    
    private var previousPostion: CGPoint?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.velocity(in: scrollView).x > 0 {
            listner?.fetchWebtoons(nextPostion: scrollView.contentOffset.x, scrollDirection: .left)
        } else if scrollView.panGestureRecognizer.velocity(in: scrollView).x < 0 {
            listner?.fetchWebtoons(nextPostion: scrollView.contentOffset.x, scrollDirection: .right)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard let previousPostion = previousPostion else {
            self.previousPostion = scrollView.contentOffset
            return
        }
        if scrollView.contentOffset.x < previousPostion.x {
            self.previousPostion = scrollView.contentOffset
        } else if scrollView.contentOffset.x > previousPostion.x {
            self.previousPostion = scrollView.contentOffset
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        listner?.updateCurrentUpdateday(offset: scrollView.contentOffset.x)
    }
}
