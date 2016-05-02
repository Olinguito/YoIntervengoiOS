//
//  History.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/4/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit
import SwiftyJSON

class History: UIView {
    var data:JSON!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(index:Int, frame:CGRect, data:JSON) {
        super.init(frame:frame)
        
        let history:UIView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 400))
        history.backgroundColor = UIColor.whiteColor()
        self.addSubview(history)
        
        _ = NSMutableArray()
        let descriptions = NSMutableArray()
        for (index,history_node) in (data[0]["history-nodes"]).enumerate(){
            descriptions[index] = ["icon":"btn_add_links_otros","title":history_node.1["description"].string!,"date":String.getDate(history_node.1["date"].string!),"desc":"Pepe Veraz"]
        }
        
        
        let timeLine = TimeLineViewControl(timeArray: descriptions, andCurrentStatus: 0, andFrame: CGRect(x: 0, y: 30, width: frame.width, height: self.frame.height))
        
        
        
        self.addSubview(timeLine)
        
        history.frame = CGRect(x: 0, y: 0, width: frame.width, height:  timeLine.height() + 250)
        self.frame = CGRect(x: 0, y: 0, width: frame.width, height:  timeLine.height() + 250)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
