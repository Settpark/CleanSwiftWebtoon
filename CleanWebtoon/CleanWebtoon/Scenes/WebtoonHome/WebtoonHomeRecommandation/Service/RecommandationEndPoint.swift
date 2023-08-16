//
//  RecommandationEndPointConvertible.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/16.
//

import Foundation


struct RecommandationEndPoint: EndPointConvertible {
    typealias requestType = WebtoonHomeRecommandation.RecommandationWebtoonModel.Request
    private let baseURL: String
    
    init() {
        self.baseURL = "https://korea-webtoon-api.herokuapp.com/"
    }
    
    
    func makeEndPoint(request: WebtoonHomeRecommandation.RecommandationWebtoonModel.Request) -> URLComponents {
        var endPointComponent: URLComponents = URLComponents(string: self.baseURL) ?? URLComponents()
        endPointComponent.queryItems = [URLQueryItem(name: "service", value: String(describing: request.service)),
                                        URLQueryItem(name: "page", value: String(describing: request.page)),
                                        URLQueryItem(name: "updateDay", value: String(describing: request.updateDay.rawValue)),
                                        URLQueryItem(name: "perPage", value: String(describing: request.perPage))]
        return endPointComponent
    }
}
