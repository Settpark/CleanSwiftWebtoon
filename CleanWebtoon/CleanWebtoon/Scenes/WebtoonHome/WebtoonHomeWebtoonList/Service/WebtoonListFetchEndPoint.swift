//
//  EndPoint.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/27.
//

import Foundation

struct EndPoint {
    private let baseURL: String
    
    init() {
        self.baseURL = "https://korea-webtoon-api.herokuapp.com/"
    }
    
    func makeEndpoint(page: Int,
                      perPage: Int,
                      service: WebtoonSupplier,
                      updateDay: WebtoonHomeWebtoonList.UpdateDay) -> URLComponents {
        var endPointComponent: URLComponents = URLComponents(string: self.baseURL) ?? URLComponents()
        endPointComponent.queryItems = [URLQueryItem(name: "page", value: String(describing: page)),
                                        URLQueryItem(name: "perPage", value: String(describing: perPage)),
                                        URLQueryItem(name: "service", value: String(describing: service)),
                                        URLQueryItem(name: "updateDay", value: String(describing: updateDay))]
        return endPointComponent
    }
    
    func makeEndpoint(service: WebtoonSupplier) -> URLComponents {
        var endPointComponent: URLComponents = URLComponents(string: self.baseURL) ?? URLComponents()
        endPointComponent.queryItems = [URLQueryItem(name: "service", value: String(describing: service))]
        return endPointComponent
    }
    
    func makeEndpoint(service: WebtoonSupplier,
                      request: WebtoonHomeWebtoonList.WebtoonModels.Request) -> URLComponents {
        var endPointComponent: URLComponents = URLComponents(string: self.baseURL) ?? URLComponents()
        endPointComponent.queryItems = [URLQueryItem(name: "service", value: String(describing: service)),
                                        URLQueryItem(name: "page", value: String(describing: request.page)),
                                        URLQueryItem(name: "updateDay", value: String(describing: request.updateDay.rawValue)),
                                        URLQueryItem(name: "perPage", value: String(describing: request.perPage))]
        return endPointComponent
    }
}
