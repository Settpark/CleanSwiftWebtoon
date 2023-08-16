//
//  WebtoonListRequest.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/16.
//

import Foundation

enum APIError: Error {
    case failMakeValidURL
    case failDecode
    case notValidData
}

struct WebtoonListFetchService {    
    func fetchSpecificDayWebtoons(request: WebtoonHomeWebtoonList.WebtoonModels.Request,
                                  completion: @escaping (Result<WebtoonHomeWebtoonList.WebtoonModels.Response, Error>) -> Void) {
        let endPoint: URLComponents = EndPoint().makeEndpoint(service: .naver,
                                                              request: request)
        guard let validURL = endPoint.url else {
            completion(.failure(APIError.failMakeValidURL))
            return
        }
        let requestMaker = RequestMaker(url: validURL, method: .get)
        URLSession.shared.dataTask(with: requestMaker.request) { data, response, error in
            if let validData = data {
                do {
                    let decoded = try JSONDecoder().decode(WebtoonHomeWebtoonList.WebtoonModels.Response.self, from: validData)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(APIError.notValidData))
            }
        }.resume()
    }
    
    func fetchRecommandWebtoons(completion: @escaping (Result<WebtoonHomeWebtoonList.WebtoonModels.Response, Error>) -> Void) {
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
                    let decoded = try JSONDecoder().decode(WebtoonHomeWebtoonList.WebtoonModels.Response.self, from: validData)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(APIError.notValidData))
            }
        }.resume()
    }
}
