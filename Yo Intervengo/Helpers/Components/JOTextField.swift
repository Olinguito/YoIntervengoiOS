//
//  JOTextField.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/12/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class JOTextField: UITextField,UITextFieldDelegate {
    var type:NSString = "Empty"
    var placeHolder:NSString = ""
    var leftV:UIView!
    var icon:UIButton!
    
    
    override func awakeFromNib() {
        delegate = self
        layer.cornerRadius = 5
        layer.borderWidth = 1
        leftV = UIView(frame: CGRect(x:0, y: 1, width: 45, height: 52))
        leftV.backgroundColor = UIColor.whiteColor()
        icon = UIButton.buttonWithType(UIButtonType.System) as UIButton
        icon.frame = CGRect(x: 0, y: 0, width: 35, height: 52)
        
        leftV.addSubview(icon)
        
        var left = Gradient(frame: CGRect(x: 35, y: 0, width: 4, height:52), type: "Left")
        left.alpha = 0.3
        leftV.addSubview(left)
        
        leftView = leftV
        tintColor = UIColor.orangeYI()
        
        font = UIFont(name: "Roboto-Regular", size: 15)
        
        self.leftViewMode = UITextFieldViewMode.Always
        
        switch type {
            case "email": setEmail(self)
            case "password": setPassword(self)
            case "confpassword": setConfPassword(self)
            case "username": setUsername(self)
            default: print("")
        }
        self.keyboardAppearance = UIKeyboardAppearance.Dark
        deselected()
    }
    
    func setUsername(textField:UITextField!){
        icon.setImage(UIImage(named: "bgUsername"), forState: UIControlState.Normal)
        textField.placeholder = "Nombre de usuario"
        textField.keyboardType = UIKeyboardType.EmailAddress
        textField.autocorrectionType = UITextAutocorrectionType.No
    }
    
    func setEmail(textField:UITextField!){
        icon.setImage(UIImage(named: "bgEmail"), forState: UIControlState.Normal)
        textField.placeholder = "ejemplo@email.com"
        textField.keyboardType = UIKeyboardType.EmailAddress
        textField.autocorrectionType = UITextAutocorrectionType.No
    }

    func setPassword(textField:UITextField!){
        icon.setImage(UIImage(named: "bgPassword"), forState: UIControlState.Normal)
        textField.placeholder = "Contraseña"
        textField.secureTextEntry = true
    }
    
    func setConfPassword(textField:UITextField!){
        icon.setImage(UIImage(named: "bgConfPassword"), forState: UIControlState.Normal)
        textField.placeholder = "Confirmar contraseña"
        textField.secureTextEntry = true
    }
    
    
    
    //MARK: - STYLE METHODS
    func deselected(){
        layer.borderColor = UIColor.greyLight().CGColor
        icon.backgroundColor = UIColor.whiteColor()
        icon.tintColor = UIColor.orangeYI()
    }
    
    func selected(){
        layer.borderColor = UIColor.orangeYI().CGColor
        icon.backgroundColor = UIColor.orangeYI()
        icon.tintColor = UIColor.whiteColor()
    }
    
    //MARK: - TEXTFIELD DELEGATE
    func textFieldDidBeginEditing(textField: UITextField) {
        selected()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        deselected()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
