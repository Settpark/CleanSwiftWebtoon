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
        var requestMaker = RequestMaker(url: url, method: .get)
        requestMaker.request.addValue(requestMaker.agentHeaderValue,
                                      forHTTPHeaderField: "User-Agent")
        let task = URLSession.shared.dataTask(with: requestMaker.request) { data, _, error in
            if let _ = error {
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
    
    static func resizeImage(image: UIImage, newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
