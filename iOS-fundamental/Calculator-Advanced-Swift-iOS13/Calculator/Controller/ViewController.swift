//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var caculator = CaculatorLogic()
    
    private var isTypingNumberFinished = true
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label to a Double")
            }
            
            return number
        }
        
        set {
            displayLabel.text = String(newValue)
        }
    }   
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isTypingNumberFinished = true
        
        caculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            if let result = caculator.calculate(symbol: calcMethod) {
                displayValue = result                
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let labelText = displayLabel.text, let numValue = sender.currentTitle {
            if isTypingNumberFinished {
                displayLabel.text = numValue
                isTypingNumberFinished = false
            } else {
                if numValue == "." && labelText.contains(".") {
                    return
                }
                displayLabel.text = labelText + numValue
            }
        }
    
    }

}

