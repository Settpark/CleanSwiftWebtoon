//
//  WebtoonDetailListFetchService.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/28.
//

import Foundation

struct WebtoonDetailListFetchService {

    func requestWebtoonDetailList(request: WebtoonDetailList.DetailList.Request,
                                  completion: @escaping (Result<WebtoonDetailList.DetailList.Response, Error>) -> Void) {
        let fileURL = Bundle.main.url(forResource: "DetailList", withExtension: "json")
        guard let fileURL = fileURL, let data = try? Data(contentsOf: fileURL) else {
            print("Not Valid FILE URL")
            return
        }
        do {
            let decoded = try JSONDecoder().decode(WebtoonDetailList.DetailList.Response.self, from: data)
            completion(.success(decoded))
        } catch {
            completion(.failure(error))
        }
    }
}
