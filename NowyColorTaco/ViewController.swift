//
//  ViewController.swift
//  NowyColorTaco
//
//  Created by Tomek Buslowski on 13.10.2017.
//  Copyright © 2017 Tomek Buslowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var rgbSegmentedControl: UISegmentedControl!

    @IBOutlet weak var rLabel: UILabel!
    @IBOutlet weak var gLabel: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    @IBOutlet weak var cLabel: UILabel!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var kLabel: UILabel!
    
    @IBOutlet weak var rTextField: UITextField!
    @IBOutlet weak var gTextField: UITextField!
    @IBOutlet weak var bTextField: UITextField!
    @IBOutlet weak var cTextField: UITextField!
    @IBOutlet weak var mTextField: UITextField!
    @IBOutlet weak var yTextField: UITextField!
    @IBOutlet weak var kTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func rgbSegmentedAction(_ sender: Any) {
        setUIControls(rgbHidden: rgbSegmentedControl.selectedSegmentIndex == 1)
        
    }
    
    @IBAction func rgbValueChanged(_ sender: Any) {
        updateCMYK()
    }
    
    @IBAction func cmykValueChanged(_ sender: Any) {
        updateRGB()
    }
    
    
    // - MARK: Private Actions
    private func setUIControls(rgbHidden: Bool) {
        self.rLabel.isHidden = rgbHidden
        self.gLabel.isHidden = rgbHidden
        self.bLabel.isHidden = rgbHidden
        self.cLabel.isHidden = !rgbHidden
        self.mLabel.isHidden = !rgbHidden
        self.yLabel.isHidden = !rgbHidden
        self.kLabel.isHidden = !rgbHidden
        
        self.rTextField.isHidden = rgbHidden
        self.gTextField.isHidden = rgbHidden
        self.bTextField.isHidden = rgbHidden
        self.cTextField.isHidden = !rgbHidden
        self.mTextField.isHidden = !rgbHidden
        self.yTextField.isHidden = !rgbHidden
        self.kTextField.isHidden = !rgbHidden
    }
    
    private func updateRGB() {
        self.rTextField.text = String(1-min(1, self.cTextField.float() * (1-self.kTextField.float()) + self.kTextField.float()))
        self.gTextField.text = String(1-min(1, self.mTextField.float() * (1-self.kTextField.float()) + self.kTextField.float()))
        self.bTextField.text = String(1-min(1, self.yTextField.float() * (1-self.kTextField.float()) + self.kTextField.float()))
    }
    
    private func updateCMYK() {
        self.cTextField.text = String( (1 - self.rTextField.float() - self.kTextField.float())/(1-self.kTextField.float()) )
        self.mTextField.text = String( (1 - self.gTextField.float() - self.kTextField.float())/(1-self.kTextField.float()) )
        self.yTextField.text = String( (1 - self.bTextField.float() - self.kTextField.float())/(1-self.kTextField.float()) )
        self.kTextField.text = String(min(1.0 - self.rTextField.float(), 1.0 - self.gTextField.float(), 1.0 - self.bTextField.float()))
    }
    
}

//extension String {
//    func isFloat() -> Bool {
//        return Float(self) != nil
//    }
//}
//
//extension UITextField {
//    func float() -> Float {
//        return self.text!.isFloat() ? Float(text!.self)! : 0.0
//    }
//}

