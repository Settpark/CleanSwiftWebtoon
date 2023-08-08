//
//  WebtoonsAPI.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/27.
//

import Foundation

struct WebtoonsHomeAPI {
    func fetchLastUpdateTime(completion: @escaping (Result<WebtoonHomeModels.LastUpdateModel, Error>) -> Void) {
        let url = Bundle.main.url(forResource: "LastUpdate", withExtension: "json")
        guard let url = url else {
            return
        }
        let data = try? Data(contentsOf: url)
        guard let data = data else {
            return
        }
        do {
            let decoded = try JSONDecoder().decode(WebtoonHomeModels.LastUpdateModel.self, from: data)
            completion(.success(decoded))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchSpecificDayWebtoons(request: WebtoonHomeModels.WebtoonModel.Request,
                                  completion: @escaping (Result<WebtoonHomeModels.WebtoonModel.Response, Error>) -> Void) {
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
                    let decoded = try JSONDecoder().decode(WebtoonHomeModels.WebtoonModel.Response.self, from: validData)
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
    
    func fetchRecommandWebtoons(completion: @escaping (Result<WebtoonHomeModels.WebtoonModel.Response, Error>) -> Void) {
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
                    let decoded = try JSONDecoder().decode(WebtoonHomeModels.WebtoonModel.Response.self, from: validData)
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