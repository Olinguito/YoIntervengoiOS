//
//  SelectCategoryViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/8/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import UIKit

class SelectCategoryViewController: UIViewController {
    var btnBack:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnBack = UIButton(frame: CGRectMake(0,0,100,100))
        btnBack.backgroundColor = UIColor.blackColor()
        btnBack.addTarget(self, action: #selector(self.goBack), forControlEvents: .TouchUpInside)
        self.view.addSubview(btnBack)
    }
    
    func goBack(){
        NSNotificationCenter.defaultCenter().postNotificationName("testTest", object: "Holaaaaaa")
        //        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
