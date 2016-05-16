//
//  SelectReportTypeViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/8/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import UIKit

public class SelectReportTypeViewController: BlurredViewController, TypeSelectorViewDelegate{
    private var typeSelector:TypeSelectorView!
    
    public override func viewDidLoad() {        
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(animated: Bool) {
        let point = CGPointMake(self.view.frame.size.width - 33, self.view.frame.size.height - 33)
        typeSelector         = TypeSelectorView(point: point, frame: self.view.frame)
        typeSelector.control = self
        self.view.addSubview(typeSelector)
        typeSelector.showMenu()
    }
    
    internal func selectedItem(type: Type) {
        (self.navigationController as! ReportNavigationViewController)._setType(type)
    }
}
