//
//  Double+Extension.swift
//  TipCalculator
//
//  Created by Sunggon Park on 2024/04/16.
//

import Foundation

extension Double {
    var stringValue: String {
        String(self)
    }
    
    var currencyFormatted: String {
        var isWholeNumber: Bool {
            isZero ? true: !isNormal ? false: self == rounded()
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        
        return formatter.string(for: self) ?? ""
    }
}
