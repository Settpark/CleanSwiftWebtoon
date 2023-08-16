//
//  WebtoonHomeWebtoonListModels.swift
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

enum WebtoonHomeWebtoonList {
    // MARK: Use cases
    enum UpdateDay: String, CaseIterable {
        case everyDayPlus = "naverDaily"
        case mon
        case tue
        case wed
        case thu
        case fri
        case sat
        case sun
        case finished
    }
    
    enum WebtoonModels {
        struct Request {
            var page: Int
            var perPage: Int
            var service: String
            var updateDay: WebtoonHomeWebtoonList.UpdateDay
            
            static var empty = Self.init()
            
            init(page: Int, perPage: Int, service: String, updateDay: WebtoonHomeWebtoonList.UpdateDay) {
                self.page = page
                self.perPage = perPage
                self.service = service
                self.updateDay = updateDay
            }
            
            init() {
                page = 0
                perPage = 0
                service = ""
                updateDay = .everyDayPlus
            }
        }
        struct Response: Decodable {
            var webtoons: [WebtoonModel]
        }
        
        struct WebtoonModel: Decodable {
            var title: String
            var author: String
            var url: String
            var img: String
            var service: String
            var updateDays: [String]
            var additional: ResponseAdditional
            
            static var empty = Self.init()
            
            init() {
                self.title = ""
                self.author = ""
                self.url = ""
                self.img = ""
                self.service = ""
                self.updateDays = []
                self.additional = ResponseAdditional.empty
            }
        }
        struct ResponseAdditional: Decodable {
            var new: Bool
            var adult: Bool
            var rest: Bool
            var up: Bool
            var singularityList: [String]
            
            static var empty = Self.init()
            
            init() {
                new = false
                adult = false
                rest = false
                up = false
                singularityList = []
            }
        }
        struct ViewModel: Hashable {
            var title: String
            var author: String
            var img: String
            var isNew: Bool
            var isAdult: Bool
            var isRest: Bool
            var isUp: Bool
            var isOver15: Bool
            var isFree: Bool
            var isWaitFree: Bool
            
            init(title: String, author: String, img: String, isNew: Bool, isAdult: Bool,
                 isRest: Bool, isUp: Bool, isOver15: Bool, isFree: Bool, isWaitFree: Bool) {
                self.title = title
                self.author = author
                self.img = img
                self.isNew = isNew
                self.isAdult = isAdult
                self.isRest = isRest
                self.isUp = isUp
                self.isOver15 = isOver15
                self.isFree = isFree
                self.isWaitFree = isWaitFree
            }
        }
    }
}
