//
//  GenericViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/16/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class GenericViewController: UIViewController,APIManagerDelegate,LeftMenuDelegate {
    var conn:Connection!
    var APIManagerClass:APIManager!
    var alert:JOAlert!
    var menuView: LeftMenu!
    var actView:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = JOAlert(textNFrame: "", self.view.frame)
        menuView = LeftMenu(frame: CGRect(x: -204, y: 0, width: 204, height: view.frame.height))
        menuView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func goTo(index: Int) {
        if actView != index {
            switch (index){
                case 1: print(1)
                case 2: print(2)
                case 3: print(3)
                case 4: print(4)
                default: print(5)
            }
        }
    }
}
