//
//  ViewController.swift
//  CustomSwitch
//
//  Created by Sunggon Park on 2024/03/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var switchView: UIView!
    @IBOutlet weak var switchThumb: UIButton!
    @IBOutlet weak var thumbXConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchView.layer.cornerRadius = switchView.bounds.height / 2
        switchThumb.layer.cornerRadius = switchThumb.bounds.height / 2
    }

    @IBAction func switchTapped(_ sender: UIButton) {
        let left: CGFloat = -75
        let right: CGFloat = 75
        if thumbXConstraint.constant == left {
            UIView.animate(withDuration: 0.3) {
                self.thumbXConstraint.constant = right
                self.view.layoutIfNeeded()
            }
            
            UIView.animate(withDuration: 1) {
                self.switchView.backgroundColor = UIColor.yellow
                self.view.layoutIfNeeded()
            }
            
            
        } else {
            thumbXConstraint.constant = left
            switchView.backgroundColor = UIColor.lightGray
            doAnimate()
        }
        
        
    }
    
    private func doAnimate() {
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
}

