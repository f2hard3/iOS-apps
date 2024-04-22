//
//  UIResponder+Extension.swift
//  TipCalculator
//
//  Created by Sunggon Park on 2024/04/16.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
