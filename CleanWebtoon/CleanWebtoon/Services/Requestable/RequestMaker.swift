//
//  Request.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/27.
//

import Foundation

protocol ServiceRequestable {
    var request: URLRequest { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct RequestMaker: ServiceRequestable {
    var request: URLRequest
   
    init(url: URL,
         method: HTTPMethod) {
        self.request = URLRequest(url: url)
        self.request.httpMethod = method.rawValue
    }
}
