//
//  info.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/4/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class Info: UIView {
    var wikiBar:UIView!
    var comment:UIButton!
    var tabBar:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(index:Int) {
        super.init(frame:CGRectZero)
        tabBar = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 139))
        tabBar.backgroundColor = UIColor.whiteColor()
        addSubview(tabBar)
        
        var grad3 = Gradient(frame: CGRect(x: 0, y: self.tabBar.frame.height - 10, width: 320, height: 10), type: "Bottom")
        grad3.alpha = 0.2
        tabBar.addSubview(grad3)
        
        wikiBar = UIView(frame: CGRect(x: 0, y: tabBar.frame.maxY, width: 320, height: 67))
        wikiBar.backgroundColor = UIColor.greyButtons()
        addSubview(wikiBar)
        
        comment = UIButton(frame: CGRect(x: 0, y: wikiBar.frame.maxY, width: 320, height: 49))
        comment.backgroundColor = UIColor(red:0.180, green:0.180, blue:0.180, alpha: 1)
        comment.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        comment.setTitle("199 Comentarios", forState: UIControlState.Normal)
        comment.titleLabel?.font = UIFont(name: "Roboto-Light", size: 13)
        comment.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        comment.setImage(UIImage(named: "comment"), forState: UIControlState.Normal)
        comment.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        comment.contentEdgeInsets = UIEdgeInsetsMake(0, 26, 0, 0)
        addSubview(comment)
        
        self.frame = CGRect(x: 0, y: 0, width: 320, height: tabBar.frame.height + wikiBar.frame.height + comment.frame.height )
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}