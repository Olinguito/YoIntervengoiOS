//
//  Shadow.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/18/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import Foundation


import UIKit


class Gradient: UIView{
    let colorTop    = UIColor(red:0.000, green:0.000, blue:0.000, alpha: 0.6).CGColor
    let colorBottom = UIColor(red:0.000, green:0.000, blue:0.000, alpha: 0.0).CGColor
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(frame: CGRect, type: String = "Top") {
        super.init(frame: frame)
        let mapGrad = CAGradientLayer()
        mapGrad.colors = ((type == "Top") ? [colorTop,colorBottom] : [colorBottom,colorTop])
        mapGrad.locations = [0,1]
        mapGrad.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self.layer.insertSublayer(mapGrad, atIndex: 0)
    }
}