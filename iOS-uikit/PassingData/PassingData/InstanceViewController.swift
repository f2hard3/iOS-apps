//
//  InstanceViewController.swift
//  PassingData
//
//  Created by Sunggon Park on 2024/03/18.
//

import UIKit

class InstanceViewController: UIViewController {
    var mainVC: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func sendToMain(_ sender: UIButton) {
        mainVC?.mainLabel.text = "from instance"
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
