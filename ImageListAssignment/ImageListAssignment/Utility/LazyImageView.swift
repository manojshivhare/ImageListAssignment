//
//  LazyImageView.swift
//  ImageListAssignment
//
//  Created by Manoj Shivhare on 16/04/24.
//

import Foundation
import UIKit

class LazyImageView: UIImageView{
    
    private var imageCache = NSCache<AnyObject, UIImage>()
    
    func loadImageView(imageUrl: URL) {
        
        if let imageCached = imageCache.object(forKey: imageUrl as AnyObject){
            self.image = imageCached
        }else{
            DispatchQueue.global().async {[weak self] in
                if let imageData = try? Data(contentsOf: imageUrl){
                    if let image = UIImage(data: imageData){
                        DispatchQueue.main.async {
                            self?.imageCache.setObject(image, forKey: imageUrl as AnyObject)
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
