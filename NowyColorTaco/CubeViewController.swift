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
        let redImage = UIImage.imageWithSize(size: CGSize(width: 255, height: 255), color: UIColor.red)
        let greImage = UIImage.imageWithSize(size: CGSize(width: 255, height: 255), color: UIColor.green)
        let bluImage = UIImage.imageWithSize(size: CGSize(width: 255, height: 255), color: UIColor.blue)
        let yelImage = UIImage.imageWithSize(size: CGSize(width: 255, height: 255), color: UIColor.yellow)
        let purImage = UIImage.imageWithSize(size: CGSize(width: 255, height: 255), color: UIColor.purple)
        let oraImage = UIImage.imageWithSize(size: CGSize(width: 255, height: 255), color: UIColor.orange)
        // 2.5
//        let greenMaterial = SCNMaterial()
//        greenMaterial.diffuse.contents = UIColor.green
//        greenMaterial.locksAmbientWithDiffuse = true
        
        let redMaterial = SCNMaterial()
        redMaterial.diffuse.contents = redImage
        redMaterial.locksAmbientWithDiffuse = true
        
        let greMaterial = SCNMaterial()
        greMaterial.diffuse.contents = greImage
        greMaterial.locksAmbientWithDiffuse = true
        
        let bluMaterial = SCNMaterial()
        bluMaterial.diffuse.contents = bluImage
        bluMaterial.locksAmbientWithDiffuse = true
        
        let yelMaterial = SCNMaterial()
        yelMaterial.diffuse.contents = yelImage
        yelMaterial.locksAmbientWithDiffuse = true
        
        let purMaterial = SCNMaterial()
        purMaterial.diffuse.contents = purImage
        purMaterial.locksAmbientWithDiffuse = true
        
        let oraMaterial = SCNMaterial()
        oraMaterial.diffuse.contents = oraImage
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
