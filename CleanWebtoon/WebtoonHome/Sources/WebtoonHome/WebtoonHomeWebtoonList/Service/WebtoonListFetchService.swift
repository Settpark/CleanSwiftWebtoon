//
//  WebtoonListRequest.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/16.
//

import Foundation
import WebtoonService

enum APIError: Error {
    case failMakeValidURL
    case failDecode
    case notValidData
}

struct WebtoonListFetchService {
    func fetchSpecificDayWebtoons(request: WebtoonHomeWebtoonList.WebtoonModels.Request,
                                  completion: @escaping (Result<WebtoonHomeWebtoonList.WebtoonModels.Response, Error>) -> Void) {
        let endPoint: URLComponents = WebtoonServiceEndPoint<WebtoonHomeWebtoonList.WebtoonModels.Request>().makeEndPoint(request: request)
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
