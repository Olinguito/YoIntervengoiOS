//
//  Pictures.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/4/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class Pictures: UIView{
    var picCont:PicContainer!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(index:Int, frame:CGRect, ini:CGFloat) {
        super.init(frame:CGRectZero)
        var ms = NSMutableArray()
        self.backgroundColor = UIColor.whiteColor()
        ms.addObject(UIImage(named: "bg1")!)
        picCont = PicContainer(frame: CGRect(x: 0, y: 0, width: frame.width, height: ((frame.height - ini))-55), array: ms)
        self.addSubview(picCont)
        
        self.frame = CGRect(x: 0, y: 0, width: frame.width, height: (frame.height - CGFloat(ini))-55)
    }
    
    
}