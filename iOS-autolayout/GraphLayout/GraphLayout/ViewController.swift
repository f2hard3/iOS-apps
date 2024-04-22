//
//  ViewController.swift
//  GraphLayout
//
//  Created by Sunggon Park on 2024/03/14.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var heightConstraint1: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint2: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint3: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint4: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint5: NSLayoutConstraint!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightConstraint1 = heightConstraint1.changeMultiplier(value: 0.9)
        heightConstraint2 = heightConstraint2.changeMultiplier(value: 0.8)
        heightConstraint3 = heightConstraint3.changeMultiplier(value: 0.7)
        heightConstraint4 = heightConstraint4.changeMultiplier(value: 0.6)
        heightConstraint5 = heightConstraint5.changeMultiplier(value: 0.9)
    }
    
    @IBAction func button1Tapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint1 = self.heightConstraint1.changeMultiplier(value: 0.5)
            self.heightConstraint2 = self.heightConstraint2.changeMultiplier(value: 0.6)
            self.heightConstraint3 = self.heightConstraint3.changeMultiplier(value: 0.7)
            self.heightConstraint4 = self.heightConstraint4.changeMultiplier(value: 0.8)
            self.heightConstraint5 = self.heightConstraint5.changeMultiplier(value: 0.9)
            
            self.view.layoutIfNeeded()
        }
      
    }
    
    @IBAction func button2Tapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint1 = self.heightConstraint1.changeMultiplier(value: 0.7)
            self.heightConstraint2 = self.heightConstraint2.changeMultiplier(value: 0.4)
            self.heightConstraint3 = self.heightConstraint3.changeMultiplier(value: 0.2)
            self.heightConstraint4 = self.heightConstraint4.changeMultiplier(value: 0.8)
            self.heightConstraint5 = self.heightConstraint5.changeMultiplier(value: 0.3)
            
            self.view.layoutIfNeeded()
        }
    }
}

extension NSLayoutConstraint {
    func changeMultiplier(value: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(item: self.firstItem, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: value, constant: self.constant)
        newConstraint.priority = self.priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        
        return newConstraint
    }
}

