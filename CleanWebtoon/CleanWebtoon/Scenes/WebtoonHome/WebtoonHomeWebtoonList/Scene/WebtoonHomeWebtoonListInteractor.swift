//
//  WebtoonHomeWebtoonListInteractor.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/16.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol WebtoonHomeWebtoonListBusinessLogic {
    func doSomething(request: WebtoonHomeWebtoonList.WebtoonModels.Request)
}

protocol WebtoonHomeWebtoonListDataStore {
    //var name: String { get set }
}

class WebtoonHomeWebtoonListInteractor: WebtoonHomeWebtoonListBusinessLogic, WebtoonHomeWebtoonListDataStore {
    var presenter: WebtoonHomeWebtoonListPresentationLogic?
    var worker: WebtoonHomeWebtoonListWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: WebtoonHomeWebtoonList.WebtoonModels.Request) {
        worker = WebtoonHomeWebtoonListWorker()
        worker?.requestWetoons(request: request,
                               completion: { response in
            self.presenter?.presentWebtoons(response: response)
        })
    }
}
