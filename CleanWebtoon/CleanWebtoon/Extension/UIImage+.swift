//
//  UIImage+.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/28.
//

import UIKit

extension UIImage {
    static func loadImage(from url: String, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: url) else {
            completion(nil)
            return nil
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(nil)
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        return task
    }

}
