//
//  Request.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/27.
//

import Foundation

public protocol ServiceRequestable {
    var request: URLRequest { get }
    var agentHeaderValue: String { get }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public struct RequestMaker: ServiceRequestable {
    public var request: URLRequest
    public var agentHeaderValue: String = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36"
    
    public init(url: URL,
                method: HTTPMethod) {
        self.request = URLRequest(url: url)
        self.request.httpMethod = method.rawValue
    }
    
//    init(url: URL,
//         method: HTTPMethod) {
//        self.request = URLRequest(url: url)
//        self.request.httpMethod = method.rawValue
//    }
}
