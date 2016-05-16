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
    
    var type:Type!
    var category:Category!
    var subcategory:Category!
    
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
    
    func _goBack(){
        self.popViewControllerAnimated(false)
    }
    
    func _setType(type:Type){
        self.type      = type
        navigator.type = type
        let view2      = SelectCategoryViewController()
        view2.type     = type
        self.pushViewController(view2, animated: false)
    }
    
    func _setCategory(category:Category){
        self.category = category
        navigator.category = category
        let view3         = SelectSubcategoryViewController()
        view3.category    = category
        self.pushViewController(view3, animated: false)
    }
    
    func _setSubcategory(category:Category){
        self.subcategory = category
        //                navigator.category = category
        let mapView      = SelectLocationViewController()
        mapView.type     = self.type
        self.pushViewController(mapView, animated: false)
    }
    
}

extension ReportNavigationViewController:NavigationViewDelegate{
    func closeNavigationReport() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cleanType() {
        self.popToRootViewControllerAnimated(false)
    }
    
    func cleanCategory() {
        self.popViewControllerAnimated(false)
    }
}
