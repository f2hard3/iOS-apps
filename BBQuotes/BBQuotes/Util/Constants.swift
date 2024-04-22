//
//  Constants.swift
//  BBQuotes
//
//  Created by Sunggon Park on 2024/04/04.
//

import Foundation
import SwiftUI

struct K {
    static let bbName = "Breaking Bad"
    static let bcsName = "Better Call Saul"
    
    static let previewCharacter: Character = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        
        return try! decoder.decode([Character].self, from: data)[0]
    }()
}

extension String {
    var replaceSpaceWithPlus: String {
        self.replacingOccurrences(of: " ", with: "+")
    }
    
    var lowerNoSpaces: String {
        self.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var buttonColor: Color {
        self == K.bbName
        ? .breakingBadButton
        : .betterCallSaulButton
    }
    
    var shadowColor: Color {
        self == K.bbName
        ? .breakingBadShadow
        : .betterCallSaulShadow
    }
}
