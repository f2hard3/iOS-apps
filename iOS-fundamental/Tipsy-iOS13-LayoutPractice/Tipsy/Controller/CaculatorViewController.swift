//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CaculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var caclulatorBrain = CaculatorBrain()
    
    var tipPct = "10%"
    var split = 2

    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        tipPct = sender.currentTitle!
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        split = Int(sender.value)
        splitNumberLabel.text = String(split)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let billText = billTextField.text ?? ""
        
        if billText != "" {
            caclulatorBrain.calcuate(billText: billText, tipPct: tipPct, split: split)
            performSegue(withIdentifier: "resultViewController", sender: self)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultViewController" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.result = caclulatorBrain.result
            destinationVC.split = split
            destinationVC.tipPct = tipPct
        }
    }
}

