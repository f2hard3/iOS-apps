//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import CoreML

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    override func viewDidLoad() {
        textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction private func predictPressed(_ sender: Any) {
        print("Search Text:", textField.text!)
        
        let data = fetchData()
        guard let score = predict(with: data) else {
            fatalError("Failed to predict")
        }
        
        updateUI(with: score)
    }
    
    private func fetchData() -> [TwitterSentimentClassifierInput]  {
        let manager = Manager()
        
        return manager.classifierInput
    }
    
    private func predict(with inputs: [TwitterSentimentClassifierInput]) -> Int? {
        guard let classifier = try? TwitterSentimentClassifier() else {
            fatalError("Falied to load classifier")
        }
        
        do {
            let predictions = try classifier.predictions(inputs: inputs)
            let score = predictions.reduce(into: 0) { partialResult, pred in
                if pred.label == "Pos" {
                    partialResult += 1
                } else if pred.label == "Neg" {
                    partialResult -= 1
                }
            }
            
            return score
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func updateUI(with score: Int) {
        if score > 20 {
            sentimentLabel.text = "😍"
        } else if score > 10 {
            sentimentLabel.text = "😃"
        } else if score > 0 {
            sentimentLabel.text = "🙂"
        } else if score == 0 {
            sentimentLabel.text = "😐"
        } else if score > -10 {
            sentimentLabel.text = "😕"
        } else if score > -20 {
            sentimentLabel.text = "😡"
        } else {
            sentimentLabel.text = "🤮"
        }
    }
}
