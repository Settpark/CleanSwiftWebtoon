//
//  WebtoonDetailListModels.swift
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

enum WebtoonDetailList {
    // MARK: Use cases
    
    enum DetailList {
        struct Request: Decodable {
            var webtoonTitle: String
        }
        struct Response: Decodable {
            var id: String
            var title: String
            var thumbnailImage: String
            var author: String
            var detailDescription: String
            var age: String
            var tags: [String]
            var webtoonList: [ResponseDetailModel]
        }
        struct ResponseDetailModel: Decodable {
            var id: String
            var title: String
            var subTitle: String?
            var rating: String
            var date: String
            var img: String
        }
        struct ViewModel: Hashable {
            var title: String
            var subTitle: String?
            var rating: String
            var date: String
            var img: String
            var cacheKey: String
        }
    }
    
    enum DetailTitlePart {
        struct ViewModel {
            var title: String
            var imageCacheKey: String
            var thumbnailImage: String
            var author: String
            var detailDescription: String
            var age: String
            var tags: [String]
        }
    }
}
