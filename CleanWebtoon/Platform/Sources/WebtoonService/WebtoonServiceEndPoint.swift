//
//  EndPoint.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/27.
//

import Foundation

public protocol WebtoonRequestable {
    var page: Int { get }
    var perPage: Int { get }
    var service: WebtoonSupplier { get }
    var updateDay: UpdateDay { get }
}

public struct WebtoonServiceEndPoint<T: WebtoonRequestable> {
    private let baseURL: String
    
    public init() {
        self.baseURL = "https://korea-webtoon-api.herokuapp.com/"
    }
    
    
    public func makeEndPoint(request: T) -> URLComponents {
        var endPointComponent: URLComponents = URLComponents(string: self.baseURL) ?? URLComponents()
        endPointComponent.queryItems = [URLQueryItem(name: "service", value: String(describing: request.service)),
                                        URLQueryItem(name: "page", value: String(describing: request.page)),
                                        URLQueryItem(name: "updateDay", value: String(describing: request.updateDay.rawValue)),
                                        URLQueryItem(name: "perPage", value: String(describing: request.perPage))]
        return endPointComponent
    }
}
