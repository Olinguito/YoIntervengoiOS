//
//  JOTabBar.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/30/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class JOTabBar: UIView {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect, data:NSMutableArray) {
        super.init(frame: frame)
        var counter = 0
        var w = (frame.size.width/CGFloat(data.count))
        for button in data {
            var xAxis = CGFloat(counter)*w
            var but: UIButton = UIButton(frame: CGRect(x: xAxis, y: 0, width: w, height: frame.size.height))
        }
    }
}
