//
//  GenericViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/16/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class GenericViewController: UIViewController {
    var conn:Connection!
    var APIManagerClass:APIManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIManagerClass = APIManager()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
