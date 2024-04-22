//
//  MovieModel.swift
//  MovieApp
//
//  Created by Sunggon Park on 2024/03/21.
//

import Foundation

struct MovieModel: Codable {
    let resultCount: Int
    let results: [MovieResult]
}

struct MovieResult: Codable {
    let title: String?
    let shortDescription: String?
    let longDescription: String?
    let previewUrl: String?
    let imageUrl: String?
    let price: Double?
    let currency: String?
    let date: String?
     
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case shortDescription
        case longDescription
        case previewUrl = "previewUrl"
        case imageUrl = "artworkUrl100"
        case price = "trackPrice"
        case currency
        case date = "releaseDate"
    }
}

