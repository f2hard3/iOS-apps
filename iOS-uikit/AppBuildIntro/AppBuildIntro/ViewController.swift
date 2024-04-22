//
//  ViewController.swift
//  AppBuildIntro
//
//  Created by Sunggon Park on 2024/03/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        
        self.present(detailVC, animated: true)
    }
    
}

