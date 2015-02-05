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
        
        self.frame = CGRect(x: 0, y: 0, width: 320, height:  history.frame.height )
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
