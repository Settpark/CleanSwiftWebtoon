//
//  RecommandationWebtoonFetchService.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/16.
//

import Foundation

struct RecommandationWebtoonFetchService {
    func fetchRecommandWebtoons(requestModel: WebtoonHomeRecommandation.RecommandationWebtoonModel.Request,
                                completion: @escaping (Result<WebtoonHomeWebtoonList.WebtoonModels.Response, Error>) -> Void) {
        let endPointConvertible: EndPointConvertible =  RecommandationEndPoint()
        let endPoint: URLComponents = endPointConvertible.makeEndPoint(request: requestModel)
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
