//
//  ViewController.swift
//  CustomKeyboard
//
//  Created by Sunggon Park on 2024/03/14.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var upperTextField: UITextField!
    @IBOutlet weak var lowerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customKeyboard = Bundle.main.loadNibNamed("CustomKeyboard", owner: nil)?.first {
            let upperTextFieldKeyboardView = customKeyboard as? CustomKeyboard
            upperTextFieldKeyboardView?.delegate = self
            upperTextField.inputView = upperTextFieldKeyboardView
        }
    }
}

extension ViewController: CustomKeyboardDelegate {
    func keyboardTapped(withInput input: String) {
        if let currentText = upperTextField.text {
            let oldNumber = Int(currentText)
            
            if input == "00", let oldNumber = oldNumber {
                upperTextField.text = formatNumber(oldNumber * 100)
            } else if input == "000", let oldNumber = oldNumber {
                upperTextField.text = formatNumber(oldNumber * 1000)
            } else {
                upperTextField.text = formatNumber(Int(input)!)
            }
        } else {
            upperTextField.text = formatNumber(Int(input)!)
        }
    }
    
    func formatNumber(_ number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: number)) ?? ""
    }
}

