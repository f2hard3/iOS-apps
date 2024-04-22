//
//  SoundEffect.swift
//  HPTrivia
//
//  Created by Sunggon Park on 2024/04/11.
//

import Foundation

enum SoundEffect {
    case flip
    case wrong
    case correct
    
    var musicFile: String {
        switch self {
        case .flip:
            "page-flip"
        case .wrong:
            "negative-beeps"
        case .correct:
            "magic-wand"
        }
    }
}
