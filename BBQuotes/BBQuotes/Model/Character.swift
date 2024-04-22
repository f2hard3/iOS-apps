//
//  Character.swift
//  BBQuotes
//
//  Created by Sunggon Park on 2024/04/04.
//

import Foundation

struct Character: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let portrayedBy: String
}
