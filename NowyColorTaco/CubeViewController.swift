//
//  CubeViewController.swift
//  NowyColorTaco
//
//  Created by Tomek Buslowski on 14.10.2017.
//  Copyright © 2017 Tomek Buslowski. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class CubeViewController: UIViewController {

    @IBOutlet weak var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sceneSetup()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        sceneView.stop(nil)
        sceneView.play(nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.stop(nil)
    }
    // MARK: Scene
    func sceneSetup() {
        // 1
        let scene = SCNScene()
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = UIColor(white: 0.67, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)
        
        //        let omniLightNode = SCNNode()
        //        omniLightNode.light = SCNLight()
        //        omniLightNode.light!.type = SCNLight.LightType.omni
        //        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        //        omniLightNode.position = SCNVector3Make(0, 25, 50)
        //        scene.rootNode.addChildNode(omniLightNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 30)
        scene.rootNode.addChildNode(cameraNode)
        
        //2.4
//        let redImage = UIImage.imageWithSize(size: CGSize(width: 255, height: 255), color: UIColor.red)
//        let greImage = UIImage.imageWithSize(size: CGSize(width: 255, height: 255), color: UIColor.green)
//        let bluImage = UIImage.imageWithSize(size: CGSize(width: 255, height: 255), color: UIColor.blue)
//        let yelImage = UIImage.imageWithSize(size: CGSize(width: 255, height: 255), color: UIColor.yellow)
//        let purImage = UIImage.imageWithSize(size: CGSize(width: 255, height: 255), color: UIColor.purple)
//        let oraImage = UIImage.imageWithSize(size: CGSize(width: 255, height: 255), color: UIColor.orange)
        // 2.5
//        let greenMaterial = SCNMaterial()
//        greenMaterial.diffuse.contents = UIColor.green
//        greenMaterial.locksAmbientWithDiffuse = true
        
        let redMaterial = SCNMaterial()
        redMaterial.diffuse.contents = UIImageView.init(image: #imageLiteral(resourceName: "cube1"))
        redMaterial.locksAmbientWithDiffuse = true
        
        let greMaterial = SCNMaterial()
        greMaterial.diffuse.contents = UIImageView.init(image: #imageLiteral(resourceName: "cube6")) //cube 6
        greMaterial.locksAmbientWithDiffuse = true
        
        let bluMaterial = SCNMaterial()
        bluMaterial.diffuse.contents = UIImageView.init(image: #imageLiteral(resourceName: "cube3"))
        bluMaterial.locksAmbientWithDiffuse = true
        
        let yelMaterial = SCNMaterial()
        yelMaterial.diffuse.contents = UIImageView.init(image: #imageLiteral(resourceName: "cube5"))  // cube 5
        yelMaterial.locksAmbientWithDiffuse = true
        
        let purMaterial = SCNMaterial()
        purMaterial.diffuse.contents = UIImageView.init(image: #imageLiteral(resourceName: "cube4")) //cube4
        purMaterial.locksAmbientWithDiffuse = true
        
        let oraMaterial = SCNMaterial()
        oraMaterial.diffuse.contents = UIImageView.init(image: #imageLiteral(resourceName: "cube2")) // cube 2
        oraMaterial.locksAmbientWithDiffuse = true
        
        // 2
        let boxGeometry = SCNBox(width: 10.0, height: 10.0, length: 10.0, chamferRadius: 0.3)
        boxGeometry.materials = [redMaterial, greMaterial, bluMaterial, yelMaterial, purMaterial, oraMaterial]
        let boxNode = SCNNode(geometry: boxGeometry)
        scene.rootNode.addChildNode(boxNode)
        
        // 3
        sceneView.scene = scene
        //sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
    }
    
}


extension UIImage {
    static func imageWithSize(size : CGSize, color : UIColor = UIColor.white) -> UIImage? {
        var image:UIImage? = nil
        UIGraphicsBeginImageContext(size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.addRect(CGRect(origin: CGPoint.zero, size: size));
            context.drawPath(using: .fill)
            image = UIGraphicsGetImageFromCurrentImageContext();
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}
