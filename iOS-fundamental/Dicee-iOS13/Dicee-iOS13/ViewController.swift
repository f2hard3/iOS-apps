//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        let diceOne =  UIImage(imageLiteralResourceName: "DiceOne")
        let diceTwo = UIImage(imageLiteralResourceName: "DiceTwo")
        let diceThree = UIImage(imageLiteralResourceName: "DiceThree")
        let diceFour = UIImage(imageLiteralResourceName: "DiceFour")
        let diceFive = UIImage(imageLiteralResourceName: "DiceFive")
        let diceSix = UIImage(imageLiteralResourceName: "DiceSix")
        
        let dices = [diceOne, diceTwo, diceThree, diceFour, diceFive, diceSix]

        diceImageView1.image = dices[Int.random(in: dices.startIndex...dices.endIndex - 1)]
        diceImageView2.image = dices[Int.random(in: 0...5)]
    }
}

