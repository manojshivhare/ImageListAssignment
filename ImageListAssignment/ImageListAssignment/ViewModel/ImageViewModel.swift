//
//  ImageViewModel.swift
//  ImageListAssignment
//
//  Created by Manoj Shivhare on 16/04/24.
//

import Foundation

protocol ImageVMProtocol{
    func recieveApiResponse(responseArr: [ImageModel]?, error: Error?)
}

struct ImageViewModel {
    //MARK: ----------Varibale----------
    var delegate: ImageVMProtocol
    
    //MARK: ----------Init----------
    init(delegate: ImageVMProtocol) {
        self.delegate = delegate
    }
    
    func getAllImagesFromAPI(){
        ApiManager.shared.getImageArrFromAPI() { response, error in
            delegate.recieveApiResponse(responseArr: response, error: error)
        }
    }
}
