//
//  History.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/4/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class History: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(index:Int) {
        super.init(frame:CGRectZero)
       
        var history:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 400))
        history.backgroundColor = UIColor.whiteColor()
        self.addSubview(history)
        
        
        
        var times = ["Enero 26 2015","Enero 26 2015","Febrero 26 2025","Enero 26 2015","Enero 26 2015","Febrero 26 2025"]
        var descriptions = ["Enero 26 2015","Enero 26 2015","Febrero 26 2025","Enero 26 2015","Enero 26 2015","Febrero 26 2025"]
        
        var timeLine = TimeLineViewControl(timeArray: times, andTimeDescriptionArray: descriptions, andCurrentStatus: 0, andFrame: CGRect(x: 0, y: 30, width: 320, height: self.frame.height))
        
        self.addSubview(timeLine)
        
        history.frame = CGRect(x: 0, y: 0, width: 320, height:  timeLine.height() + 50)
        self.frame = CGRect(x: 0, y: 0, width: 320, height:  timeLine.height() + 50)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
