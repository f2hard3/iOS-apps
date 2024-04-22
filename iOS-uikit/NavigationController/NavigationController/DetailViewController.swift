//
//  DetailViewController.swift
//  NavigationController
//
//  Created by Sunggon Park on 2024/03/22.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }  
    
    private func setupNavBar() {
        statusBarView?.backgroundColor = .red        
        navigationController?.navigationBar.backgroundColor = .red
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
