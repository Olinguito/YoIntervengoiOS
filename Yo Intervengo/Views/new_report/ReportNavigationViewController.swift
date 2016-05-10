//
//  ReportNavigationViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/9/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import UIKit

public class ReportNavigationViewController: UINavigationController {
    
    var navigator:NavigationView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        navigator = NavigationView()
        navigator.delegate = self
        self.view.addSubview(navigator)
        
        let option = NSLayoutFormatOptions(rawValue: 0)
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[navigator]|", options: option, metrics: nil, views: ["navigator":navigator]))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[navigator(50)]-8-|", options: option, metrics: nil, views: ["navigator":navigator]))
        
        navigator.openNavigation()
    }
}

extension ReportNavigationViewController:NavigationViewDelegate{
    func closeNavigationReport() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
