//
//  SelectCategoryViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/8/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import UIKit

public class SelectCategoryViewController: BlurredViewController {
    private var btnBack:UIButton!
    internal var type:Type?
    
    override public func viewDidLoad() {
        super.viewDidLoad()        
        btnBack = UIButton(frame: CGRectMake(0,0,100,100))
        btnBack.backgroundColor = UIColor.blackColor()
        btnBack.addTarget(self, action: #selector(self.goBack), forControlEvents: .TouchUpInside)
        self.view.addSubview(btnBack)
    }
    
    func goBack(){
        (self.navigationController as! ReportNavigationViewController).navigator.subtype = self.type?.categories?.allObjects.first as? Category
    }
}
