//
//  PostData.swift
//  Hacker-News
//
//  Created by Sunggon Park on 2024/02/29.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
