//
//  ViewController.swift
//  CustomButtom
//
//  Created by Sunggon Park on 2024/03/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var upButton: RotateButton!
    @IBOutlet weak var downButton: RotateButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        upButton.TappedCallback = { direction in
            print(direction)
        }
        
        downButton.TappedCallback = { direction in
            print(direction)
        }
        
        guard let button = makeButton(title: "Rotate") as? RotateButton else { return }
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80).isActive = true
    }
    
    private func makeButton(title: String) -> UIButton {
        let button = RotateButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.backgroundColor = .blue
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(systemName: "arrowtriangle.down"), for: .normal)
        
        button.configure()
        
        return button
    }
}

