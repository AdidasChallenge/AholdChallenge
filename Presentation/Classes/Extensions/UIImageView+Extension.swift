//
//  UIImageView+Extension.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 05/05/2021.
//

import UIKit
import Foundation
import Kingfisher

private let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    /**
     Downloads an image from URL
     - Parameter link: URL of the image
     - Parameter mode: Content mode (Options to specify how a view adjusts its content when its size changes)
     */
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, defaultImage: UIImage? = UIImage(named: "default-icon")) {
        let link = makeStringURLFriendly(string: link)
        
        let imageUrlString = link
        
        guard let url = URL(string: link) else {
            image = defaultImage ?? UIImage()
            return
        }
        
        if let imageFromCache = imageCache.object(forKey: link as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let imageToCache = UIImage(data: data)
            else {
                let image = UIImage(named: "default-icon") ?? UIImage()
                imageCache.setObject(image, forKey: link as AnyObject)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                if imageUrlString == link {
                    self?.image = imageToCache
                }
                imageCache.setObject(imageToCache, forKey: link as AnyObject)
            }
        }.resume()
    }
    
    private func makeStringURLFriendly(string: String) -> String {
        return string.replacingOccurrences(of: " ", with: "%20")
    }
    
    func downloadedAsync(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        let url = URL(string: link)
        let processor = DownsamplingImageProcessor(size: CGSize(width: max(bounds.size.width, 1024), height: max(bounds.size.height, 1024)))
            |> RoundCornerImageProcessor(cornerRadius: 5)
        kf.indicatorType = .activity
        kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.5))
            ])
    }
}

