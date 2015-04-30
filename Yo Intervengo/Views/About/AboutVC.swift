//
//  AboutVC.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 4/29/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class AboutVC: GenericViewController {
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actView = 2
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
