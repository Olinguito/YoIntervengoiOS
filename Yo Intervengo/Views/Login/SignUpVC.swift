//
//  SignUpVC.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/12/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var txtUsername: JOTextField!
    @IBOutlet weak var txtEmail: JOTextField!
    @IBOutlet weak var txtConfPassword: JOTextField!
    @IBOutlet weak var txtPassword: JOTextField!
    @IBOutlet weak var btnSendReg: UIButton!
    
    @IBOutlet weak var bg: UIView!
    var singleTap:UIGestureRecognizer!
    var singleTap2:UIGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSendReg.layer.cornerRadius = 5
        btnSendReg.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        singleTap = UITapGestureRecognizer(target: self, action: Selector("singleTap:"))
        singleTap2 = UITapGestureRecognizer(target: self, action: Selector("singleTap:"))
        self.view.addGestureRecognizer(singleTap)
        bg.addGestureRecognizer(singleTap2)
    }
    
    func singleTap(sender:UITapGestureRecognizer){
        txtUsername.resignFirstResponder()
        txtConfPassword.resignFirstResponder()
        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
