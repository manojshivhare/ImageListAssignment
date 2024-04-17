//
//  ImageModel.swift
//  ImageListAssignment
//
//  Created by Manoj Shivhare on 16/04/24.
//

import Foundation

struct ImageModel : Decodable {
    let id: String
    let title: String
    let language: String
    let thumbnail: Thumbnail
    let publishedAt: String
    let publishedBy: String
    let coverageURL: String
    let mediaType: Int
}

struct Thumbnail: Decodable{
    let id: String
    let version: Int
    let domain: String
    let basePath: String
    let key: String
    let qualities: [Int]
    let aspectRatio: Int
}
