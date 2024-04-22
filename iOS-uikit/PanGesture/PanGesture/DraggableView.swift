//
//  DraggableView.swift
//  PanGesture
//
//  Created by Sunggon Park on 2024/03/19.
//

import UIKit

class DraggableView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var draggableType: DraggableType?
    
    init() {
        super.init(frame: CGRect.zero)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(doDrag))
        addGestureRecognizer(panGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func doDrag(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
//        case .began:
//            print("began")

        case .changed:
            let delta = gesture.translation(in: superview)
            var myPostion = self.center
            
            if draggableType == .x {
                myPostion.x += delta.x
            } else if draggableType == .y {
                myPostion.y += delta.y
            } else {
                myPostion.x += delta.x
                myPostion.y += delta.y
            }
            
            self.center = myPostion
            gesture.setTranslation(CGPoint.zero, in: superview)
            
        case .ended, .cancelled:
            if frame.minX < 0 {
                frame.origin.x = 0
            }
                        
            if let superview = superview {
                if frame.maxX > superview.frame.maxX {
                    frame.origin.x = superview.frame.maxX - frame.width
                }
                
                if frame.minY < superview.safeAreaInsets.top {
                    frame.origin.y = superview.safeAreaInsets.top + 50
                }
                
                if frame.maxY > superview.frame.maxY {
                    frame.origin.y = superview.frame.maxY - frame.height
                }
            }
            
        default:
            break
        }
        
    }
}
