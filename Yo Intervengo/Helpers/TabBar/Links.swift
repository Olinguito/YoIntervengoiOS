//
//  Links.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/4/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class Links: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(index:Int, frame:CGRect ) {
        super.init(frame:CGRectZero)
        backgroundColor = UIColor.whiteColor()

        var counter = 10
        for (var i=0; i<counter; i++){
            var link = LinkComponent(type: 1,frame:CGRectMake(0, 0, frame.width, 106))
            link.frame.origin = CGPoint(x: 0, y: 106*i)
            self.addSubview(link)
        }
        
        self.frame = CGRect(x: 0, y: 0, width:frame.width, height: CGFloat((106*counter) + 200))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
