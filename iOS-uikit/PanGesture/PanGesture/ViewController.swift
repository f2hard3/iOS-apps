//
//  ViewController.swift
//  PanGesture
//
//  Created by Sunggon Park on 2024/03/19.
//

import UIKit

enum DraggableType {
    case x
    case y
    case both
}

class ViewController: UIViewController {
    let draggableView = DraggableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {        
        draggableView.draggableType = .both
        draggableView.center = view.center
        draggableView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        draggableView.backgroundColor = .blue
        
        view.addSubview(draggableView)
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            draggableView.draggableType = .both
            
        case 1:
            draggableView.draggableType = .x
            
        case 2:
            draggableView.draggableType = .y
            
        default:
            break
        }
    }
    
}

