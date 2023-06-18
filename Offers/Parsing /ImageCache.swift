//
//  ImageCachd.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import UIKit
// MARK: - ImageCache

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingCache(withUrl url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.image = placeholder
                }
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                
                if let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    self?.image = image
                } else {
                    self?.image = placeholder
                }
            }
        }).resume()
    }
}
