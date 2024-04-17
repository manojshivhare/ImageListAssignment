//
//  ApiManager.swift
//  ImageListAssignment
//
//  Created by Manoj Shivhare on 16/04/24.
//

import Foundation
import UIKit

struct FlickerImageUrl {
    static let searchURl = "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=100"
}

//MARK: ----------API manager class----------
class ApiManager{
    //MARK: ----------Singleton Object---------
    static let shared = ApiManager()
    //MARK: ----------variable----------------
    let session = URLSession(configuration: .default)
    var request : NSMutableURLRequest = NSMutableURLRequest()
    
    //MARK: ----------Image Search API----------------
    func getImageArrFromAPI(_ complition: @escaping ([ImageModel]?, Error?)->()) {
        guard let url = URL(string: FlickerImageUrl.searchURl) else {return}
        request.url = url
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else  { 
                complition(nil, error)
                return
            }
            
            do{
                let imageArr = try JSONDecoder().decode([ImageModel].self, from: data)
                complition(imageArr, nil)
            }catch{
                complition(nil, error)
            }
        }
        task.resume()
    }
    
}
