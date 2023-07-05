//
//  Cache.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/07/05.
//

import UIKit

class ImageCacheManger {
    static let shared: ImageCacheManger = ImageCacheManger()
    
    private let cache: NSCache = NSCache<NSString, UIImage>()
    
    private init() {
        cache.countLimit = 10000
        cache.totalCostLimit = 1024 * 1024 * 500
    }
    
    func loadCachedImage(forKey: String) -> UIImage? {
        let key = NSString(string: forKey)
        guard let image: UIImage = cache.object(forKey: key) else {
            return nil
        }
        return image
    }
    
    func cacheImage(forKey: String, image: UIImage) {
        let key = NSString(string: forKey)
        cache.setObject(image, forKey: key)
    }
}
