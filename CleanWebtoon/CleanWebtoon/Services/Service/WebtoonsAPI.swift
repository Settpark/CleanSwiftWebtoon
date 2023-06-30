//
//  WebtoonsAPI.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/27.
//

import Foundation

struct WebtoonsAPI: ServiceLayer {
    func fetchSpecificDayWebtoons(updateDay: UpdateDay,
                                  completion: @escaping (Result<WebtoonHome.WebtoonList.Response, Error>) -> Void) {
        let endPoint: URLComponents = EndPoint().makeEndpoint(service: .kakao,
                                                              updateDay: updateDay)
        guard let validURL = endPoint.url else {
            completion(.failure(APIError.failMakeValidURL))
            return
        }
        let requestMaker = RequestMaker(url: validURL, method: .get)
        
        URLSession.shared.dataTask(with: requestMaker.request) { data, response, error in
            if let validData = data {
                do {
                    let decoded = try JSONDecoder().decode(WebtoonHome.WebtoonList.Response.self, from: validData)
                    completion(.success(decoded))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            } else {
                completion(.failure(APIError.notValidData))
            }
        }.resume()
    }
    
    func fetchRecommandWebtoons(completion: @escaping (Result<WebtoonHome.WebtoonList.Response, Error>) -> Void) {
        let endPoint: URLComponents = EndPoint().makeEndpoint(page: 1,
                                                              perPage: 10,
                                                              service: .kakao,
                                                              updateDay: .sun)
        guard let validURL = endPoint.url else {
            completion(.failure(APIError.failMakeValidURL))
            return
        }
        let requestMaker = RequestMaker(url: validURL, method: .get)
        URLSession.shared.dataTask(with: requestMaker.request) { data, response, error in
            if let validData = data {
                do {
                    let decoded = try JSONDecoder().decode(WebtoonHome.WebtoonList.Response.self, from: validData)
                    completion(.success(decoded))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
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
