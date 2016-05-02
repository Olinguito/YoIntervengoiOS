//
//  LoginVC.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/11/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    var backgroundImage:UIImageView!
    var overlay:UIView!
    
    @IBOutlet weak var logoDark: UIImageView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSignUp.titleLabel?.font = UIFont(name: "Roboto-Light", size: 12.5)
        
        
        let myMutableString = NSMutableAttributedString(string: "¿Ya posees una cuenta? Inicia sesión", attributes: [NSFontAttributeName:UIFont(name: "Roboto-Light", size: 12.5)!])
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.greyDark(), range: NSRange(location:0,length:23))
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeYI(), range: NSRange(location:23,length:13))
        
        btnSignIn.titleLabel?.textAlignment = NSTextAlignment.Center
        btnSignIn.setAttributedTitle(myMutableString, forState: .Normal)
        
        _ = btnSignIn.frame.maxY
        _ = self.view.frame.height
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
