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
    
    var colorView:UIColor!
    var data:NSDictionary!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(index:Int, data:NSDictionary, color:UIColor, frame:CGRect) {
        super.init(frame:CGRectZero)
        var wS:CGFloat = frame.width
        self.data = data
        self.colorView = color
        tabBar = UIView(frame: CGRect(x: 0, y: 0, width: wS, height: max(139, frame.width-140)))
        tabBar.backgroundColor = UIColor.whiteColor()
        addSubview(tabBar)
        backgroundColor = UIColor(red:0.180, green:0.180, blue:0.180, alpha: 1)
        var grad3 = Gradient(frame: CGRect(x: 0, y: self.tabBar.frame.height - 10, width: wS, height: 10), type: "Bottom")
        grad3.alpha = 0.2
        tabBar.addSubview(grad3)
        
        var lblInfo = UILabel()
        var text = self.data["description"] as! String
        lblInfo.text = text
        lblInfo.textColor = UIColor.greyDark()
        lblInfo.font = UIFont(name: "RobotoSlab-Light", size: 15)
        lblInfo.numberOfLines = 0
        
        
        lblInfo.frame = CGRect(x: 25, y: 5, width: frame.width-50, height: heightForView(text, font: lblInfo.font!, width: frame.width-50))
        tabBar.addSubview(lblInfo)
        
        
        wikiBar = UIView(frame: CGRect(x: 0, y: tabBar.frame.maxY, width: wS, height: 67))
        wikiBar.backgroundColor = UIColor.greyButtons()
        addSubview(wikiBar)
        
        var butWiki = UIButton(frame: CGRect(x: lblInfo.frame.minX, y: 15, width: lblInfo.frame.width, height: 40))
        butWiki.titleLabel?.numberOfLines = 0
        butWiki.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        
        var myMutableString = NSMutableAttributedString(string: "Para lograr un mayor impacto asocia este reporte a un contrato. Enlazar a Wiki", attributes: [NSFontAttributeName:UIFont(name: "Roboto-LightItalic", size: 14.0)!])
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.greyDark(), range: NSRange(location:0,length:64))
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: self.colorView, range: NSRange(location:64,length:14))
        
        butWiki.titleLabel?.textAlignment = NSTextAlignment.Center
        butWiki.setAttributedTitle(myMutableString, forState: .Normal)
        wikiBar.addSubview(butWiki)
        
        
        comment = UIButton(frame: CGRect(x: 0, y: wikiBar.frame.maxY, width: wS, height: 49))
        comment.backgroundColor = UIColor(red:0.180, green:0.180, blue:0.180, alpha: 1)
        comment.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        comment.setTitle("199 Comentarios", forState: UIControlState.Normal)
        comment.titleLabel?.font = UIFont(name: "Roboto-Light", size: 13)
        comment.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        comment.setImage(UIImage(named: "comment"), forState: UIControlState.Normal)
        comment.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        comment.contentEdgeInsets = UIEdgeInsetsMake(0, 26, 0, 0)
        addSubview(comment)
        

        self.frame = CGRect(x: 0, y: 0, width: frame.width, height: tabBar.frame.height + wikiBar.frame.height + comment.frame.height + 200)
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return min(120, label.frame.height)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}