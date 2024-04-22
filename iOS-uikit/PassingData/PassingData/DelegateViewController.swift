//
//  DelegateViewController.swift
//  PassingData
//
//  Created by Sunggon Park on 2024/03/18.
//

import UIKit

protocol DelegateViewControllerDelegate: AnyObject {
    func passString(string: String)
}

class DelegateViewController: UIViewController {
    weak var delegate: DelegateViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


   
    @IBAction func makeDelegatePerform(_ sender: UIButton) {
        delegate?.passString(string: "from delegate")
        dismiss(animated: true)
    }
    
}
