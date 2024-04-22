//
//  SegueViewController.swift
//  PassingData
//
//  Created by Sunggon Park on 2024/03/18.
//

import UIKit

class SegueViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = text
        dismiss(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
