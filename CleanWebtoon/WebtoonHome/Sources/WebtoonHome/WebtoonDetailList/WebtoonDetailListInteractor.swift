//
//  WebtoonDetailListInteractor.swift
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

protocol WebtoonDetailListBusinessLogic
{
    func fetchWebtoonDetailList()
}

protocol WebtoonDetailListDataStore {
    var fetchTarget: String { get set }
    var index: Int { get set }
}

class WebtoonDetailListInteractor: WebtoonDetailListBusinessLogic, WebtoonDetailListDataStore {
    var presenter: WebtoonDetailListPresentationLogic?
    var worker: WebtoonDetailListWorker?
    var fetchTarget: String
    var index: Int
    
    init() {
        fetchTarget = ""
        index = 0
    }
    
    // MARK: Do something
    
    func fetchWebtoonDetailList() {
        worker = WebtoonDetailListWorker()
        let request = WebtoonDetailList.DetailList.Request(webtoonTitle: fetchTarget)
        worker?.fetchDetailList(target: request, completion: { [weak self] response in
            self?.presenter?.presentWebtoonDetailList(response: response)
        })
    }
}