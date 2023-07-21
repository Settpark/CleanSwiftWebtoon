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
    func fetchSpecificDayWebtoons(request: WebtoonHome.WebtoonList.Request, isButtonPress: Bool)
    func updateCurrent(updateDay: UpdateDay)
    func fetchRecommandWebtoons()
}

protocol WebtoonHomeDataStore {
    var webtoonStore: WebtoonListMangable { get }
}

class WebtoonHomeInteractor: WebtoonHomeBusinessLogic, WebtoonHomeDataStore {

    var presenter: WebtoonHomePresentationLogic?
    
    var webtoonStore: WebtoonListMangable
    private var worker: WebtoonHomeWorker
    private var lastUpdateDay: UpdateDay?
    private let coreDataManager: CoreDataManager
    
    init() {
        webtoonStore = WebtoonListsManager()
        worker = WebtoonHomeWorker(service: WebtoonsAPI())
        lastUpdateDay = nil
        coreDataManager = CoreDataManager(persistentContainerName: "WebtoonCacheModel")
        coreDataManager.deleteData(type: WebtoonEntity.self, targetTitle: nil) //TODO: 모두 지우는 함수.
    }
    
    func fetchSpecificDayWebtoons(request: WebtoonHome.WebtoonList.Request,
                                  isButtonPress: Bool) {
        if lastUpdateDay == request.updateDay {
            return
        }
        lastUpdateDay = request.updateDay
        self.worker.isAlreadyFetch(targetDate: request.updateDay) { [weak self] in
            if $0 {
                let fetchedData = self?.coreDataManager.fetchData(type: WebtoonEntity.self,
                                                                  predicate: request.updateDay)
                guard let fetchedData = fetchedData,
                      fetchedData.count != 0 else {
                    self?.fetchWebtoons(option: request,
                                        isButtonPress: isButtonPress)
                    return
                }
                self?.sendToPresenterFromCoreData(fetchedData: fetchedData,
                                                  updateDay: request.updateDay)
                if isButtonPress {
                    self?.moveToSpecificdayWebtoonlist(updateday: request.updateDay)
                }
            } else {
                self?.fetchWebtoons(option: request,
                                    isButtonPress: isButtonPress)
            }
        }
    }
    
    func fetchWebtoons(option: WebtoonHome.WebtoonList.Request,
                       isButtonPress: Bool) {
        worker.fetchSpecificDayWebtoons(request: option) { [weak self] response in
            guard let self = self else {
                return
            }
            response.webtoons.forEach {
                let entity = self.coreDataManager.makeEntity(className: "WebtoonEntity") as? WebtoonEntity
                entity?.save(value: $0)
                if isButtonPress {
                    self.moveToSpecificdayWebtoonlist(updateday: option.updateDay)
                }
            }
            UserDefaults.standard.setValue(Date.makeTodayToString(),
                                           forKey: option.updateDay.rawValue)
            self.presenter?.presentWebtoonList(response: response,
                                               updateDay: option.updateDay)
        }
        if isButtonPress {
            moveToSpecificdayWebtoonlist(updateday: option.updateDay)
        }
    }
    
    func sendToPresenterFromCoreData(fetchedData: [WebtoonEntity], updateDay: UpdateDay) {
        presenter?.presentWebtoonList(entity: fetchedData, updateDay: updateDay)
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
