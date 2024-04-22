//
//  ViewController.swift
//  ARRuler
//
//  Created by Sunggon Park on 2024/03/09.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var dotNodes: [SCNNode] = [SCNNode]()
    
    var textNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        clearDots()
        
        if let touchLocation = touches.first?.location(in: sceneView) {
            if let hitResult = getHitResult(touchLocation: touchLocation) {
                let dotNodes = addDot(at: hitResult)
                
                if let (distance, endPosition) = calculate() {
                    updateText(text: String(distance), at: endPosition)
                }
            }
        }
    }
    
    private func getHitResult(touchLocation: CGPoint) -> ARRaycastResult? {
        if let query = sceneView.raycastQuery(from: touchLocation, allowing: .estimatedPlane, alignment: .any) {
            let hitResults = sceneView.session.raycast(query)
            
            return hitResults.first
        }
        
        return nil
    }
    
    private func addDot(at hitResult: ARRaycastResult) -> [SCNNode] {
        let dotGeometry = SCNSphere(radius: 0.005)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        
        dotGeometry.materials = [material]
        
        let dotNode = SCNNode(geometry: dotGeometry)
        dotNode.position = SCNVector3(
            x: hitResult.worldTransform.columns.3.x,
            y: hitResult.worldTransform.columns.3.y,
            z: hitResult.worldTransform.columns.3.z
        )
        
        sceneView.scene.rootNode.addChildNode(dotNode)
        dotNodes.append(dotNode)
        
        return dotNodes
    }
    
    private func calculate() -> (Float, SCNVector3)? {
        if dotNodes.count >= 2 {
            let start = dotNodes.first!
            let end = dotNodes.last!
            
            let distance = sqrt(
                    pow(end.position.x - start.position.x, 2) +
                    pow(end.position.y - start.position.y, 2) +
                    pow(end.position.z - start.position.z, 2)
            )
            return (distance, end.position)
        }
        
        return nil
    }
    
    private func updateText(text: String, at position: SCNVector3) {
        textNode.removeFromParentNode()
        
        let textGeometry = SCNText(string: text, extrusionDepth: 1.0)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.red
        
        textNode = SCNNode(geometry: textGeometry)
        
        textNode.position = SCNVector3(position.x, position.y + 0.01, position.z)
        
        textNode.scale = SCNVector3(0.01, 0.01, 0.01)
        
        sceneView.scene.rootNode.addChildNode(textNode)
    }
    
    private func clearDots() {
        if dotNodes.count >= 2 {
            for dotNode in dotNodes {
                dotNode.removeFromParentNode()
            }
            
            dotNodes = [SCNNode]()
        }
        
    }
}
