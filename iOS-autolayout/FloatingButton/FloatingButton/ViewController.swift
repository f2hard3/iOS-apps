//
//  ViewController.swift
//  FloatingButton
//
//  Created by Sunggon Park on 2024/03/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPopup" {
            if let floatingVC = segue.destination as? FloatingButtonContoller {
                floatingVC.modalPresentationStyle = .overCurrentContext
            }
        }
    }
}

