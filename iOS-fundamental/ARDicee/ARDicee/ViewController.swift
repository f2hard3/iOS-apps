//
//  ViewController.swift
//  ARDicee
//
//  Created by Sunggon Park on 2024/03/08.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var diceArray = Array<SCNNode>()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
//        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
//        let sphere = SCNSphere(radius: 0.2)
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "art.scnassets/moon.jpg")
//        sphere.materials = [material]
//        let node = SCNNode()
//        node.position = SCNVector3(0, 0.1, -0.5)
//        node.geometry = sphere
//        sceneView.scene.rootNode.addChildNode(node)
//        sceneView.debugOptions = [.showFeaturePoints]
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - Dice Rendering Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: sceneView)
            
            // will be deprecated
//            let results = sceneView.hitTest(touchLocation, types: .existingPlane)
            let query = sceneView.raycastQuery(from: touchLocation, allowing: .existingPlaneGeometry, alignment: .horizontal)
            let results = sceneView.session.raycast(query!)
            
            if let hitResult = results.first {
                addDice(atLocation: hitResult)
            }
        }
    }
    
    private func addDice(atLocation location: ARRaycastResult) {
        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
            diceNode.position = SCNVector3(
                location.worldTransform.columns.3.x,
                location.worldTransform.columns.3.y + diceNode.boundingSphere.radius,
                location.worldTransform.columns.3.z
            )
            
            diceArray.append(diceNode)
            
            sceneView.scene.rootNode.addChildNode(diceNode)
            
            roll(dice: diceNode)
            
        }
    }
    
    private func roll(dice diceNode: SCNNode) {
        let randomX = CGFloat(Float(arc4random_uniform(4) + 1) * Float.pi / 2) * 3
        let randomZ = CGFloat(Float(arc4random_uniform(4) + 1) * Float.pi / 2) * 3
        diceNode.runAction(
            SCNAction.rotateBy(x: randomX, y: 0, z: randomZ, duration: 0.5)
        )
    }
    
    private func rollAll() {
        if !diceArray.isEmpty {
            for dice in diceArray {
                roll(dice: dice)
            }
        }
    }
    
    @IBAction func rollAgain(_ sender: UIBarButtonItem) {
        rollAll()
    }
    
    @IBAction func removeAllDice(_ sender: UIBarButtonItem) {
        if !diceArray.isEmpty {
            for dice in diceArray {
                dice.removeFromParentNode()
            }
        }
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        rollAll()
    }
    
    
    // MARK: - ARSCNView Delegate Methods
    func renderer(_ renderer: any SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
       
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        let planeNode = createPlain(with: planeAnchor)
        
        node.addChildNode(planeNode)
    }
    
    // MARK: - Plance Rendering Methods
    private func createPlain(with planeAnchor: ARPlaneAnchor) -> SCNNode {
        let plane = SCNPlane(width: CGFloat(planeAnchor.planeExtent.width), height: CGFloat(planeAnchor.planeExtent.height))
        
        let gridMaterial = SCNMaterial()
        gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
        
        plane.materials = [gridMaterial]
        
        let planeNode = SCNNode()
        planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        
        planeNode.geometry = plane
        
        return planeNode
    }
}
