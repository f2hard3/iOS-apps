//
//  ViewController.swift
//  OnboardingView
//
//  Created by Sunggon Park on 2024/03/19.
//

import UIKit

class ViewController: UIViewController {
    var isLaunchedBefore: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        isLaunchedBefore = UserDefaults.standard.bool(forKey: "isLaunchedBefore")
        if !isLaunchedBefore {
            let onboardPageVC = OnboaringPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
            onboardPageVC.modalPresentationStyle = .fullScreen
            
            present(onboardPageVC, animated: true)
            UserDefaults.standard.setValue(true, forKey: "isLaunchedBefore")
        }
       
    }


}

