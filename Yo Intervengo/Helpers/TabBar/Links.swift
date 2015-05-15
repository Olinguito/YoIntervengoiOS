//
//  Links.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/4/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class Links: UIView {
    var data:JSON!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(index:Int, frame:CGRect , data:JSON) {
        super.init(frame:CGRectZero)
        self.data = data
        backgroundColor = UIColor.whiteColor()

        var counter = data[0]["links"].count
//        print(data[0]["links"][0])
        for (var i=0; i<counter; i++){
            var link = LinkComponent(type: 1,frame:CGRectMake(0, 0, frame.width, 106))
            link.frame.origin = CGPoint(x: 0, y: 106*i)
            link.iconLink.image = UIImage.getLinkImage(data[0]["links"][i]["type"].intValue)
            link.date.text = String.getDate(data[0]["links"][i]["date"].string!)
            link.title.setTitle(data[0]["links"][i]["source"].string , forState: UIControlState.Normal)
            link.subtitle.text = data[0]["links"][i]["title"].string
            self.addSubview(link)
        }
        
        self.frame = CGRect(x: 0, y: 0, width:frame.width, height: CGFloat((106*counter) + 200))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
