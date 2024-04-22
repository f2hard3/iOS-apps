//
//  RotateButton.swift
//  CustomButtom
//
//  Created by Sunggon Park on 2024/03/22.
//

import UIKit

enum Direction {
    case upward
    case downward
}

class RotateButton: UIButton {
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    var TappedCallback: ((Direction) -> Void)?
    
    private var direction: Direction = .downward {
        didSet {
            changeDirection()
        }
    }
    
    func configure() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        direction = direction == .downward ? .upward : .downward
        
        TappedCallback?(direction)
    }
    
    private func changeDirection() {
        UIView.animate(withDuration: 0.5) {
            switch self.direction {
            case .downward:
                self.imageView?.transform = .identity
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
            case .upward:
                self.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.3)
            }
            
        }
    }
}
