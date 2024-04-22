//
//  ViewController.swift
//  Poke3D
//
//  Created by Sunggon Park on 2024/03/09.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
        sceneView.automaticallyUpdatesLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Thomas Cards", bundle: .main) {
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 2
            
            print("Images successfully added")
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            let plane = SCNPlane(
                width: imageAnchor.referenceImage.physicalSize.width,
                height: imageAnchor.referenceImage.physicalSize.height
            )
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "Thomas" {
                if let trainScene = SCNScene(named: "art.scnassets/Thomas.scn") {
                    if let trainNode = trainScene.rootNode.childNodes.first {
                        trainNode.eulerAngles.x = .pi / 2
                        planeNode.addChildNode(trainNode)
                    }
                }
            }
            
            if imageAnchor.referenceImage.name == "Henry" {
                if let trainScene = SCNScene(named: "art.scnassets/Henry.scn") {
                    if let trainNode = trainScene.rootNode.childNodes.first {
                        trainNode.eulerAngles.x = .pi / 2
                        planeNode.addChildNode(trainNode)
                    }
                }
            }
            
        }
     
        return node
    }

}
