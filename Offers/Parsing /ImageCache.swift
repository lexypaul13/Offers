//
//  ImageCachd.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingCache(withUrl url: URL) {
        self.image = nil

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                
                if let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    self?.image = image
                }
            }
        }).resume()
    }
}
