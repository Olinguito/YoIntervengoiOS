//
//  GenericViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/16/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class GenericViewController: UIViewController,APIManagerDelegate {
    var conn:Connection!
    var APIManagerClass:APIManager!
    var alert:JOAlert!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = JOAlert(textNFrame: "", self.view.frame)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
