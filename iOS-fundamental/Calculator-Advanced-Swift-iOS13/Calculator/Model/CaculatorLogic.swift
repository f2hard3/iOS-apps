//
//  CaculatorLogic.swift
//  Calculator
//
//  Created by Sunggon Park on 2024/03/06.
//  Copyright © 2024 London App Brewery. All rights reserved.
//

import Foundation

struct CaculatorLogic {
    private var number: Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    mutating func calculate(symbol: String) -> Double? {
        if let number = number {
            switch symbol {
            case "AC":
                return 0
            case "+/-":
                return number * -1
            case "%":
                return number * 0.01
            case "=":
                return performTwoNumberCalculation(n2: number)
            default:
                intermediateCalculation = (number, symbol)
            }
        }
        
        return nil
    }
    
    private func performTwoNumberCalculation(n2: Double) -> Double? {
        if let (n1, operation) = intermediateCalculation {
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "*":
                return n1 * n2
            case "÷":
                return n1 / n2
            default:
                fatalError("The operation passed in does not match any of the cases.")
            }
        }
        
        return nil
    }
}
