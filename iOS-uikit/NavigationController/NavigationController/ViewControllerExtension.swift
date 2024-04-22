//
//  ViewControllerExstension.swift
//  NavigationController
//
//  Created by Sunggon Park on 2024/03/22.
//

import UIKit

extension UIViewController {
    var statusBarView: UIView? {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return nil }
        sceneDelegate.window?.addSubview(sceneDelegate.statusBarView)
        
        return sceneDelegate.statusBarView
    }


}
