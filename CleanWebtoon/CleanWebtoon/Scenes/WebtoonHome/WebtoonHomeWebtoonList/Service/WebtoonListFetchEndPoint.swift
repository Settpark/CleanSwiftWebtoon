//
//  EndPoint.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/27.
//

import Foundation

protocol EndPointConvertible {
    associatedtype requestType
    func makeEndPoint(request: requestType) -> URLComponents
}

struct WebtoonListFetchEndPoint: EndPointConvertible {
    typealias requestType = WebtoonHomeWebtoonList.WebtoonModels.Request
    private let baseURL: String
    
    init() {
        self.baseURL = "https://korea-webtoon-api.herokuapp.com/"
    }
    
    
    func makeEndPoint(request: WebtoonHomeWebtoonList.WebtoonModels.Request) -> URLComponents {
        var endPointComponent: URLComponents = URLComponents(string: self.baseURL) ?? URLComponents()
        endPointComponent.queryItems = [URLQueryItem(name: "service", value: String(describing: request.service)),
                                        URLQueryItem(name: "page", value: String(describing: request.page)),
                                        URLQueryItem(name: "updateDay", value: String(describing: request.updateDay.rawValue)),
                                        URLQueryItem(name: "perPage", value: String(describing: request.perPage))]
        return endPointComponent
    }
}
