//
//  WebtoonListsManager.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/07/10.
//

import Foundation

protocol WebtoonListMangable: AnyObject {
    var currentMondayWebtoonPage: Int { get set }
    func addMonday(webtoons: [WebtoonHome.Webtoon])
    func changeMonday(webtoons: [WebtoonHome.Webtoon])
}

class WebtoonListsManager: WebtoonListMangable {
    var currentMondayWebtoonPage: Int
    private var mondayWebtoons: [WebtoonHome.Webtoon]
    
    init() {
        currentMondayWebtoonPage = 0
        mondayWebtoons = []
    }
    
    func addMonday(webtoons: [WebtoonHome.Webtoon]) {
        webtoons.forEach { mondayWebtoons.append($0) }
    }
    
    func changeMonday(webtoons: [WebtoonHome.Webtoon]) {
        mondayWebtoons = webtoons
    }
}
