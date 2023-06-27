//
//  WebtoonsAPI.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/27.
//

import Foundation

struct WebtoonsAPI: ServiceLayer {
    func fetchAllWebtoons(completion: @escaping (Result<WebtoonHome.WebtoonList.Response, Error>) -> Void) {
        let endPoint: URLComponents = EndPoint().makeEndpoint(service: .naver)
        guard let validURL = endPoint.url else {
            completion(.failure(APIError.failMakeValidURL))
            return
        }
        let requestMaker = RequestMaker(url: validURL, method: .get)
        URLSession.shared.dataTask(with: requestMaker.request) { data, response, error in
            if let validData = data {
                let decoded = try? JSONDecoder().decode(WebtoonHome.WebtoonList.Response.self, from: validData)
                guard let decoded = decoded else {
                    completion(.failure(APIError.failDecode))
                    return
                }
                completion(.success(decoded))
            } else {
                completion(.failure(APIError.notValidData))
            }
        }.resume()
    }
}

enum APIError: Error {
    case failMakeValidURL
    case failDecode
    case notValidData
}
