//
//  PopupViewController.swift
//  FloatingButton
//
//  Created by Sunggon Park on 2024/03/14.
//

import UIKit

class FloatingButtonContoller: UIViewController {
    
    @IBOutlet weak var button1Constraint: NSLayoutConstraint!
    @IBOutlet weak var button2Constraint: NSLayoutConstraint!
    @IBOutlet weak var button3Constraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonsReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        doAnimateButtonsUp()
    }
    
    private func setButtonsReady() {
        button1Constraint.constant = 0
        button2Constraint.constant = 0
        button3Constraint.constant = 0
    }
    
    private func doAnimateButtonsUp() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5) {
            self.button1Constraint.constant = 80
            self.button2Constraint.constant = 160
            self.button3Constraint.constant = 240
            
            self.view.layoutIfNeeded()
        }
    }
    
    private func doAnimateButtonsDown() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, animations: {
            self.button1Constraint.constant = 0
            self.button2Constraint.constant = 0
            self.button3Constraint.constant = 0
            
            self.view.layoutIfNeeded()
        }) { _ in 
            self.dismiss(animated: false)
        }
    }
    
    @IBAction func dismissFloating(_ sender: UIButton) {
        doAnimateButtonsDown()
    }
}
