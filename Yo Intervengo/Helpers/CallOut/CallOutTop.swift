//
//  CallOutTop.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/13/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import Foundation
import UIKit


class CallOutTop: UIView{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red:0.761, green:0.286, blue:0.000, alpha: 1)
        let imgIcon = UIImageView(frame: CGRect(x: 23, y: 10, width: 17, height: 55))
        imgIcon.image = UIImage(named: "img1")
        self.addSubview(imgIcon)
        let title = UILabel(frame: CGRect(x: 70, y: 8, width: 112, height: 40))
        title.numberOfLines = 2
        title.font = UIFont(name: "Roboto-Light", size: 14)
        title.textColor = UIColor.whiteColor()
        title.text = "Puente Calle 33 con Av. López ..."
        self.addSubview(title)
        let subtitle = UILabel(frame: CGRect(x: 70, y: 50, width: 112, height: 10))
        subtitle.font = UIFont(name: "Roboto-Light", size: 9)
        subtitle.textColor = UIColor.whiteColor()
        subtitle.text = "Nombre Subcategoría"
        self.addSubview(subtitle)
        let imgProject = UIImageView(frame: CGRect(x: 193, y: 0, width: 76, height: frame.height))
        imgProject.image = UIImage(named: "bg1")
        self.addSubview(imgProject)
    }
}
