//
//  WebtoonHomeInteractor.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/21.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import CoreData

protocol WebtoonHomeBusinessLogic {
    func fetchSpecificDayWebtoons(option: WebtoonHome.WebtoonList.Request, isButtonPress: Bool)
    func updateCurrent(updateDay: UpdateDay)
    func fetchRecommandWebtoons()
}

protocol WebtoonHomeDataStore {
    //var name: String { get set }
}

class WebtoonHomeInteractor: WebtoonHomeBusinessLogic, WebtoonHomeDataStore {
    
    var presenter: WebtoonHomePresentationLogic?
    private var worker: WebtoonHomeWorker
    private var lastUpdateDay: UpdateDay?
    
    private let coreDataManager = CoreDataManager(persistentContainerName: "WebtoonCacheModel")
    
    init() {
        worker = WebtoonHomeWorker(service: WebtoonsAPI())
        lastUpdateDay = nil
    }
    
    func fetchSpecificDayWebtoons(option: WebtoonHome.WebtoonList.Request, isButtonPress: Bool) {
        if lastUpdateDay == option.updateDay {
            return
        }
        lastUpdateDay = option.updateDay
        worker.fetchSpecificDayWebtoons(updateDay: option.updateDay) { [weak self] response in
            guard let self = self else {
                return
            }
            self.presenter?.presentWebtoonList(response: response, updateDay: option.updateDay)
        }
        if isButtonPress {
            moveToSpecificdayWebtoonlist(updateday: option.updateDay)
        }
    }
    
    func updateCurrent(updateDay: UpdateDay) {
        self.lastUpdateDay = updateDay
    }
    
    func fetchRecommandWebtoons() {
        worker.fetchRecommandWebtoons { [weak self] response in
            guard let self = self else {
                return
            }
            self.presenter?.presentRecommandWebtoons(response: response)
        }
    }
    
    private func moveToSpecificdayWebtoonlist(updateday: UpdateDay) {
        let updateDayToInt: CGFloat = UpdateDay.makeUpdatedayToInt(updateDay: updateday)
        presenter?.presentSpecificDayWebtoons(offset: updateDayToInt)
    }
}
