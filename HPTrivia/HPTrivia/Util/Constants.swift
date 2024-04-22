//
//  Constants.swift
//  HPTrivia
//
//  Created by Sunggon Park on 2024/04/08.
//

import Foundation
import SwiftUI

struct K {
    static let hpFont = "PartyLetPlain"
    
    static let previewQuestion = try! JSONDecoder().decode([Question].self, from: Data(contentsOf: Bundle.main.url(forResource: "trivia", withExtension: "json")!))[0]
}
