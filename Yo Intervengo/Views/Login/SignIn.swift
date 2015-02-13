//
//  SignIn.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/12/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class SignIn: UIViewController {
    @IBOutlet weak var txtEmail: JOTextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForget: UIButton!
    @IBOutlet weak var txtPass: JOTextField!
    
    @IBOutlet weak var bg: UIView!
    var singleTap:UIGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myMutableString = NSMutableAttributedString(string: "¡OOPS! OLIVIDÉ MI CONTRASEÑA", attributes: [NSFontAttributeName:UIFont(name: "Roboto-Light", size: 12.5)!])
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.greyDark(), range: NSRange(location:0,length:18))
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeYI(), range: NSRange(location:18,length:10))
        
        btnForget.titleLabel?.textAlignment = NSTextAlignment.Center
        btnForget.setAttributedTitle(myMutableString, forState: .Normal)
        
        btnLogin.layer.cornerRadius = 5
        btnLogin.titleLabel?.font = UIFont(name: "Roboto-Light", size: 16)
        
        singleTap = UITapGestureRecognizer(target: self, action: Selector("singleTap:"))
        self.view.addGestureRecognizer(singleTap)
        bg.addGestureRecognizer(singleTap)
    }

    func singleTap(sender:UITapGestureRecognizer){
        txtEmail.resignFirstResponder()
        txtPass.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
