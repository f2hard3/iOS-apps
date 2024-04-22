//
//  CustomKeyboard.swift
//  CustomKeyboard
//
//  Created by Sunggon Park on 2024/03/14.
//

import UIKit

protocol CustomKeyboardDelegate {
    func keyboardTapped(withInput input: String)
}

// MARK: - Delegate
class CustomKeyboard: UIView {
    var delegate: CustomKeyboardDelegate?
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if let input = sender.titleLabel?.text {
            delegate?.keyboardTapped(withInput: input)
        }       
    }
}
