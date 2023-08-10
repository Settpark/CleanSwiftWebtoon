//
//  ScrollEventDelegate.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/10.
//

import UIKit

class ScrollEventDelegate: NSObject, UIScrollViewDelegate {
    private enum Policy {
        static let floatingPointTolerance = 0.1
    }
    
    private var innerScrollingDownDueToOuterScroll = false
    private var outerScrollView: UIScrollView?
    private var innerScrollView: UIScrollView?
    
    enum ScrollDirection {
        case none
        case up
        case down
    }
    
    func changeOuterScrollView(_ scrollView: UIScrollView) {
        outerScrollView?.delegate = nil
        outerScrollView = scrollView
        outerScrollView?.delegate = self
    }
    
    func changeInnerScrollView(_ scrollView: UIScrollView) {
        innerScrollView?.delegate = nil
        innerScrollView = scrollView
        innerScrollView?.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let outerScrollView = outerScrollView,
              let innerScrollView = innerScrollView else {
            return
        }
        // more, less 스크롤 방향의 기준: 새로운 콘텐츠로 스크롤링하면 more, 이전 콘텐츠로 스크롤링하면 less
        // ex) more scroll 한다는 의미: 손가락을 아래에서 위로 올려서 새로운 콘텐츠를 확인한다
        
        let outerScroll = outerScrollView == scrollView
        let innerScroll = !outerScroll
        let moreScroll = scrollView.panGestureRecognizer.translation(in: scrollView).y < 0
        let lessScroll = !moreScroll
        
        // outer scroll이 스크롤 할 수 있는 최대값 (이 값을 sticky header 뷰가 있다면 그 뷰의 frame.maxY와 같은 값으로 사용해도 가능)
        let outerScrollMaxOffsetY = outerScrollView.contentSize.height - outerScrollView.frame.height
        let innerScrollMaxOffsetY = innerScrollView.contentSize.height - innerScrollView.frame.height
        
        // 1. outer scroll을 more 스크롤
        // 만약 outer scroll을 more scroll 다 했으면, inner scroll을 more scroll
        if outerScroll && moreScroll {
            guard outerScrollMaxOffsetY < outerScrollView.contentOffset.y + Policy.floatingPointTolerance else { return }
            innerScrollingDownDueToOuterScroll = true
            defer { innerScrollingDownDueToOuterScroll = false }
            
            // innerScrollView를 모두 스크롤 한 경우 stop
            guard innerScrollView.contentOffset.y < innerScrollMaxOffsetY else { return }
            
            innerScrollView.contentOffset.y = innerScrollView.contentOffset.y + outerScrollView.contentOffset.y - outerScrollMaxOffsetY
            outerScrollView.contentOffset.y = outerScrollMaxOffsetY
        }
        
        // 2. outer scroll을 less 스크롤
        // 만약 inner scroll이 less 스크롤 할게 남아 있다면 inner scroll을 less 스크롤
        if outerScroll && lessScroll {
            guard innerScrollView.contentOffset.y > 0 && outerScrollView.contentOffset.y < outerScrollMaxOffsetY else { return }
            innerScrollingDownDueToOuterScroll = true
            defer { innerScrollingDownDueToOuterScroll = false }
            
            // outer scroll에서 스크롤한 만큼 inner scroll에 적용
            innerScrollView.contentOffset.y = max(innerScrollView.contentOffset.y - (outerScrollMaxOffsetY - outerScrollView.contentOffset.y), 0)
            
            // outer scroll은 스크롤 되지 않고 고정
            outerScrollView.contentOffset.y = outerScrollMaxOffsetY
        }
        
        // 3. inner scroll을 less 스크롤
        // inner scroll을 모두 less scroll한 경우, outer scroll을 less scroll
        if innerScroll && lessScroll {
            defer { innerScrollView.lastOffsetY = innerScrollView.contentOffset.y }
            print("depth0")
            guard innerScrollView.contentOffset.y < 0 && outerScrollView.contentOffset.y > 0 else { return }
            print("depth1")
            // innerScrollView의 bounces에 의하여 다시 outerScrollView가 당겨질수 있으므로 bounces로 다시 되돌아가는 offset 방지
            guard innerScrollView.lastOffsetY > innerScrollView.contentOffset.y else { return }
            
            let moveOffset = outerScrollMaxOffsetY - abs(innerScrollView.contentOffset.y) * 3
            guard moveOffset < outerScrollView.contentOffset.y else { return }
            
            outerScrollView.contentOffset.y = max(moveOffset, 0)
        }
        
        // 4. inner scroll을 more 스크롤
        // outer scroll이 아직 more 스크롤할게 남아 있다면, innerScroll을 그대로 두고 outer scroll을 more 스크롤
        if innerScroll && moreScroll {
            guard
                outerScrollView.contentOffset.y + Policy.floatingPointTolerance < outerScrollMaxOffsetY,
                !innerScrollingDownDueToOuterScroll
            else { return }
            // outer scroll를 more 스크롤
            let minOffetY = min(outerScrollView.contentOffset.y + innerScrollView.contentOffset.y, outerScrollMaxOffsetY)
            let offsetY = max(minOffetY, 0)
            outerScrollView.contentOffset.y = offsetY
            
            // inner scroll은 스크롤 되지 않아야 하므로 0으로 고정
            innerScrollView.contentOffset.y = 0
        }
        
        // todo: scroll to top 시, inner scroll도 top으로 스크롤
    }
}

private struct AssociatedKeys {
    static var lastOffsetY = "lastOffsetY"
}

extension UIScrollView {
    var lastOffsetY: CGFloat {
        get {
            (objc_getAssociatedObject(self, &AssociatedKeys.lastOffsetY) as? CGFloat) ?? contentOffset.y
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.lastOffsetY, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
