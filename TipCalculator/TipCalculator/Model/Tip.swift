//
//  Tip.swift
//  TipCalculator
//
//  Created by Sunggon Park on 2024/04/15.
//

enum Tip {
    case none
    case tenPercent
    case firteenPercent
    case twentyPercent
    case custom(value: Int)
    
    var stringValue: String {
        switch self {
        case .none:
            return ""
        case .tenPercent:
            return "10%"
        case .firteenPercent:
            return "15%"
        case .twentyPercent:
            return "20%"
        case .custom(let value):
            return "$\(value)"
        }
    }
}
