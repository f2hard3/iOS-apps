//
//  DetailViewController.swift
//  PassingData
//
//  Created by Sunggon Park on 2024/03/18.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = text
    }
}
