//
//  AppleIDViewController.swift
//  SettingCloneApp
//
//  Created by Sunggon Park on 2024/03/19.
//

import UIKit

class AppleIDViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        emailTextFieldChanged(emailTextField)
    }
    
    @IBAction func emailTextFieldChanged(_ sender: UITextField) {
        nextButton.isEnabled = sender.text?.isEmpty == true ? false : true
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
