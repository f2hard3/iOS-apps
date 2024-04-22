//
//  ViewController.swift
//  BasicConstraints
//
//  Created by Sunggon Park on 2024/03/12.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var button00: UIButton!
    @IBOutlet weak var button01: UIButton!
    @IBOutlet weak var button02: UIButton!
        
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    
    @IBOutlet weak var button20: UIButton!
    @IBOutlet weak var button21: UIButton!
    @IBOutlet weak var button22: UIButton!
    
    @IBOutlet weak var button30: UIButton!
    @IBOutlet weak var button31: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        resultLabel.layer.masksToBounds = true
        resultLabel.layer.cornerRadius = 20
        
        button00.layer.cornerRadius = button00.bounds.width / 2.0
        button01.layer.cornerRadius = button01.bounds.width / 2.0
        button02.layer.cornerRadius = button02.bounds.width / 2.0
        button10.layer.cornerRadius = button10.bounds.width / 2.0
        button11.layer.cornerRadius = button11.bounds.width / 2.0
        button12.layer.cornerRadius = button12.bounds.width / 2.0
        button20.layer.cornerRadius = button20.bounds.width / 2.0
        button21.layer.cornerRadius = button21.bounds.width / 2.0
        button22.layer.cornerRadius = button22.bounds.width / 2.0
        button30.layer.cornerRadius = button30.bounds.height / 2.0
        button31.layer.cornerRadius = button31.bounds.width / 2.0
    }
}
