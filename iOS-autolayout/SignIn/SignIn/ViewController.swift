//
//  ViewController.swift
//  SignIn
//
//  Created by Sunggon Park on 2024/03/15.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailErrorMessage: UILabel!
    @IBOutlet weak var passwordErrorMessage: UILabel!
    
    var emailHeightAnchorConstraint: NSLayoutConstraint?
    var passwordHeightAnchorConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        emailHeightAnchorConstraint = emailErrorMessage.heightAnchor.constraint(equalToConstant: 0)
        emailHeightAnchorConstraint?.isActive = true
        passwordHeightAnchorConstraint = passwordErrorMessage.heightAnchor.constraint(equalToConstant: 0)
        passwordHeightAnchorConstraint?.isActive = true
    }
    
    @IBAction func emailChanged(_ sender: UITextField) {
        if let text = sender.text {
            if isValidEmailAddr(email: text) {
                emailHeightAnchorConstraint?.isActive = true
            } else {
                emailHeightAnchorConstraint?.isActive = false
            }
        }
        
        animate()
    }
    
   
    @IBAction func passwordChanged(_ sender: UITextField) {
        if let text = sender.text {
            if isValidPassword(password: text) {
                passwordHeightAnchorConstraint?.isActive = true
            } else {
                passwordHeightAnchorConstraint?.isActive = false
            }
        }
        
        animate()
    }
    
    private func isValidEmailAddr(email: String) -> Bool {
      let emailRegEx = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"

      let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

      return predicate.evaluate(with: email)
    }
    
    private func isValidPassword(password: String) -> Bool {
        return password.count >= 8
    }
    
    private func animate() {
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
}


