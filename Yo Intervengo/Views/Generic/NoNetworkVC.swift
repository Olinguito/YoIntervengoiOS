//
//  NoNetworkVC.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/1/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class NoNetworkVC: GenericViewController {
    var lblNoConnection:UILabel!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.greyNav()
        
        lblNoConnection = UILabel(frame: CGRectMake(25, 0, self.view.frame.width-50, 80))
        lblNoConnection.text = "Para usar Yo Intervengo debes estar conectado a Internet"
        lblNoConnection.center = self.view.center
        lblNoConnection.numberOfLines = 0
        lblNoConnection.textAlignment = NSTextAlignment.Center
        lblNoConnection.font = UIFont(name: "Roboto-Light", size: 18)
        lblNoConnection.textColor = UIColor.whiteColor()
        self.view.addSubview(lblNoConnection)
    }
}
