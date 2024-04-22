//
//  ViewController.swift
//  Popup
//
//  Created by Sunggon Park on 2024/03/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func showPopup(_ sender: UIButton) {
        let popupVC = UIStoryboard(name: "PopupViewController", bundle: nil)
                        .instantiateViewController(identifier: "PopupViewController")
        popupVC.modalPresentationStyle = .overCurrentContext
        present(popupVC, animated: false)
    }
}

