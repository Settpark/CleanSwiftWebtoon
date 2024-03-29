//
//  RecommandationWebtoonFetchService.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/16.
//

import Foundation
import WebtoonService

struct RecommandationWebtoonFetchService {
    func fetchRecommandWebtoons(requestModel: WebtoonHomeRecommandation.RecommandationWebtoonModel.Request,
                                completion: @escaping (Result<WebtoonHomeRecommandation.RecommandationWebtoonModel.Response, Error>) -> Void) {
        let endPointConvertible: WebtoonServiceEndPoint = WebtoonServiceEndPoint<WebtoonHomeRecommandation.RecommandationWebtoonModel.Request>()
        let endPoint: URLComponents = endPointConvertible.makeEndPoint(request: requestModel)
        guard let validURL = endPoint.url else {
            completion(.failure(APIError.failMakeValidURL))
            return
        }
        let requestMaker: RequestMaker = .init(url: validURL, method: .get)
        URLSession.shared.dataTask(with: requestMaker.request) { data, response, error in
            if let validData = data {
                do {
                    let decoded = try JSONDecoder().decode(WebtoonHomeRecommandation.RecommandationWebtoonModel.Response.self, from: validData)
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
