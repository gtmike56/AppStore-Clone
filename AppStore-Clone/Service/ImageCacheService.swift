//
//  ImageCacheService.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-05.
//

import UIKit

class ImageCacheService {
    
    static var shared = ImageCacheService()
    
    let cache = NSCache<NSString, UIImage>()
        
    func loadAppImage(imageURL: String, completion: @escaping (UIImage?) -> ()) {

        guard let url = URL(string: imageURL) else {
            print("URL is not correct (loadAppImage)")
            return
            
        }
        
        if cache.object(forKey: imageURL as NSString) != nil {
            completion(cache.object(forKey: imageURL as NSString))
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
            
            if let error = error {
                print("Error downloading the images (loadAppImage)", error)
                return
            }
            DispatchQueue.main.async { [self] in
                if let data = data {
                    if let downloadedImage = UIImage(data: data) {
                        cache.setObject(downloadedImage, forKey: imageURL as NSString)
                        completion(downloadedImage)
                    }
                } else {
                    print("No data (loadAppImage)")
                }
            }
        }).resume()
    }
}
