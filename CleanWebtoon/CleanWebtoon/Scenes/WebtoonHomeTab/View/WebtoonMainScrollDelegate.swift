//
//  WebtoonMainScrollDelegate.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/07/10.
//

import UIKit

protocol NextWebtoonListFetcher: AnyObject {
    func fetchNextWebtoonList()
}

class WebtoonMainScrollDelegate: NSObject, UIScrollViewDelegate {
    
    weak var listner: NextWebtoonListFetcher?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.height
        
        if offsetY + scrollViewHeight >= contentHeight {
            listner?.fetchNextWebtoonList()
        }
    }
}
