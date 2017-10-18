//
//  RgbViewController.swift
//  NowyColorTaco
//
//  Created by Tomek Buslowski on 14.10.2017.
//  Copyright © 2017 Tomek Buslowski. All rights reserved.
//

import UIKit

class RgbViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var rField: UITextField!
    @IBOutlet weak var gField: UITextField!
    @IBOutlet weak var bField: UITextField!
    @IBOutlet weak var cField: UITextField!
    @IBOutlet weak var mField: UITextField!
    @IBOutlet weak var yField: UITextField!
    @IBOutlet weak var kField: UITextField!
    
    @IBOutlet weak var rSlider: UISlider!
    @IBOutlet weak var gSlider: UISlider!
    @IBOutlet weak var bSlider: UISlider!
    @IBOutlet weak var cSlider: UISlider!
    @IBOutlet weak var mSlider: UISlider!
    @IBOutlet weak var ySlider: UISlider!
    @IBOutlet weak var kSlider: UISlider!
    
    @IBOutlet weak var arrowButton: UIButton!
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var textModeLabel: UILabel!
    @IBOutlet weak var textModeSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.colorView.layer.cornerRadius = 20
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func textModeAction() {
        if textModeSwitch.isOn {
            textModeLabel.text = "Auto convert & refresh: On"
            
        } else {
            textModeLabel.text = "Auto convert & refresh: Off"
        }
    }
    
    @IBAction func convertAction() {
        if self.arrowButton.title(for: .normal) == "⬆︎" {
            convertToRgb()
        } else {
            convertToCmyk()
        }
    }
    
    @IBAction func refreshColorAction(_ sender: Any) {
        self.updateColorView()
    }
    
    @IBAction func arrowAction() {
        if self.arrowButton.title(for: .normal) == "⬇︎" {
            self.arrowButton.setTitle("⬆︎", for: .normal)
        } else {
            self.arrowButton.setTitle("⬇︎", for: .normal)
        }
    }
    
    @IBAction func resetAction() {
        if self.arrowButton.title(for: .normal) == "⬆︎" {
            UIView.animate(withDuration: 0.3, animations: {
                self.rField.text = "255"
                self.gField.text = "255"
                self.bField.text = "255"
                self.updateRgbSliders()
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.cField.text = "0.00"
                self.mField.text = "0.00"
                self.yField.text = "0.00"
                self.kField.text = "0.00"
                self.updateCmykSliders()
            }, completion: nil)
        }
        self.updateColorView()
    }
    
    @IBAction func rgbTextChanged(_ sender: Any) {
        let field = sender as! UITextField
        // Check value
        if let value = field.int() {
            if value < 0 {
                field.text = "0"
            } else if value > 255 {
                field.text = "255"
            }
        }
        // Update slider
        UIView.animate(withDuration: 0.3, animations: {
            switch field {
            case self.rField:
                self.rSlider.setValue(self.rField.float(), animated: true)
            case self.gField:
                self.gSlider.setValue(self.gField.float(), animated: true)
            case self.bField:
                self.bSlider.setValue(self.bField.float(), animated: true)
            default:
                break
            }
        }, completion: nil)
        if textModeSwitch.isOn {
            self.updateColorView()
        }
        
    }
    
    @IBAction func cmykTextChanged(_ sender: Any) {
        let field = sender as! UITextField
        // Check value
        if let value = field.float() {
            if value < 0 {
                field.text = "0.00"
            } else if value > 1 {
                field.text = "1.00"
            }
        }
        // Update slider
        UIView.animate(withDuration: 0.3, animations: {
            switch field {
            case self.cField:
                self.cSlider.setValue(self.cField.float(), animated: true)
            case self.mField:
                self.mSlider.setValue(self.mField.float(), animated: true)
            case self.yField:
                self.ySlider.setValue(self.yField.float(), animated: true)
            case self.kField:
                self.kSlider.setValue(self.kField.float(), animated: true)
            default:
                break
            }
        }, completion: nil)
        if textModeSwitch.isOn {
            self.updateColorView()
        }
    }
    
    @IBAction func rgbSliderChanged(_ sender: Any) {
        // Update texts
        let slider = sender as! UISlider
        switch slider {
        case rSlider:
            rField.text = rSlider.intString()
        case gSlider:
            gField.text = gSlider.intString()
        case bSlider:
            bField.text = bSlider.intString()
        default:
            break
        }
        if textModeSwitch.isOn {
            self.convertToCmyk()
            self.updateColorView()
        }
    }
    
    @IBAction func cmykSliderChanged(_ sender: Any) {
        // Update texts
        let slider = sender as! UISlider
        switch slider {
        case cSlider:
            cField.text = cSlider.string()
        case mSlider:
            mField.text = mSlider.string()
        case ySlider:
            yField.text = ySlider.string()
        case kSlider:
            kField.text = kSlider.string()
        default:
            break
        }
        if textModeSwitch.isOn {
            self.convertToRgb()
            self.updateColorView()
        }
    }
    
    private func convertToRgb() {
        let k = kField.float()!
        let r = 1 - min(1, (self.cField.float()*(1-k)) + k)
        let g = 1 - min(1, (self.mField.float()*(1-k)) + k)
        let b = 1 - min(1, (self.yField.float()*(1-k)) + k)
        
        self.rField.text = String(Int(round(r*255)))
        self.gField.text = String(Int(round(g*255)))
        self.bField.text = String(Int(round(b*255)))
        
        self.updateRgbSliders()
    }
    
    private func convertToCmyk() {
        let r = self.rField.float()/255
        let g = self.gField.float()/255
        let b = self.bField.float()/255
        
        let k = min(1-r, 1-g, 1-b)
        
        let c:Float! = ((1 - r - k) / (1 - k))
        let m:Float! = ((1 - g - k) / (1 - k))
        let y:Float! = ((1 - b - k) / (1 - k))
        
        self.kField.text = String(format: "%.02f", k)
        self.cField.text = String(format: "%.02f", c)
        self.mField.text = String(format: "%.02f", m)
        self.yField.text = String(format: "%.02f", y)
        
        self.updateCmykSliders()
    }
    
    private func updateRgbSliders() {
        self.rgbTextChanged(rField)
        self.rgbTextChanged(gField)
        self.rgbTextChanged(bField)
    }
    
    private func updateCmykSliders() {
        self.cmykTextChanged(kField)
        self.cmykTextChanged(cField)
        self.cmykTextChanged(mField)
        self.cmykTextChanged(yField)
    }
    
    private func updateColorView () {
        if self.arrowButton.title(for: .normal) == "⬇︎" {
            let r = 1 - min(1, (self.cField.float()*(1-self.kField.float())) + self.kField.float())
            let g = 1 - min(1, (self.mField.float()*(1-self.kField.float())) + self.kField.float())
            let b = 1 - min(1, (self.yField.float()*(1-self.kField.float())) + self.kField.float())
            
            self.colorView.backgroundColor = UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)
        } else {
            let r = self.rField.float()/255
            let g = self.gField.float()/255
            let b = self.bField.float()/255
            
            self.colorView.backgroundColor = UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)
        }
    }
}

extension String {
    func isInt() -> Bool {
        return Int(self) != nil
    }
    
    func isFloat() -> Bool {
        return Float(self) != nil
    }
}

extension UITextField {
    func int() -> Int! {
        return self.text!.isInt() ? Int(text!.self)! : 0
    }
    
    func float() -> Float! {
        return self.text!.isFloat() ? Float(text!.self)! : 0.0
    }
}

extension UISlider {
    func intString() -> String {
        return String(Int(round(self.value)))
    }
    
    func string() -> String {
        return String(format: "%.02f", self.value)
    }
}
