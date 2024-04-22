//
//  DiagonalImageView.swift
//  CustomLayoutToStoryboard
//
//  Created by Sunggon Park on 2024/03/15.
//

import UIKit

@IBDesignable
class DiagonalImageView: UIImageView {
    @IBInspectable var innerHeight: CGFloat = 0
    
    override func layoutSubviews() {
        makeMask()
    }
    
    // bezier path
    func makePath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height - innerHeight))
        path.close()
        
        return path.cgPath
    }
    
    // path -> layer
    func makeShapeLayer(with path: CGPath) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path
        
        return shapeLayer
    }
    
    // layer -> mask
    func setMask(with layer: CAShapeLayer) {
        self.layer.mask = layer
    }
    
    func makeMask() {
        let path = makePath()
        let layer = makeShapeLayer(with: path)
        setMask(with: layer)
    }
}
