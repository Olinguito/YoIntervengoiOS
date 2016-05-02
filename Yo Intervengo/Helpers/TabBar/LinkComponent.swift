//
//  LinkComponent.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/7/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class LinkComponent: UIView {
    var title:UIButton!
    var subtitle:UILabel!
    var date:UILabel!
    var actionPanel:Panel!
    var iconLink:UIImageView!
    let paddinLeft:CGFloat = 14
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    
    convenience init(type:Int, frame:CGRect) {
        self.init()
        
        if type == 1{
            self.frame = CGRect(x: 0, y: 0, width: frame.width, height: 106)
        }
        else{
            self.frame = CGRect(x: paddinLeft, y: 0, width: 292, height: 72)
            self.layer.cornerRadius = 5;
        }
        self.backgroundColor = UIColor.whiteColor()
        
        
        iconLink = UIImageView(image: UIImage(named: "Empty"))
        iconLink.frame.origin = CGPoint(x: paddinLeft,y: paddinLeft)
        self.addSubview(iconLink)
        
        date = UILabel(frame: CGRect(x: paddinLeft + iconLink.frame.maxX, y: 14, width: frame.width, height: 11))
        date.text = "Fecha de publicación"
        date.font = UIFont(name: "Roboto-Light", size: 10)
        date.textColor = UIColor.greyDark()
        addSubview(date)
        
        
        title = UIButton(frame: CGRect(x: paddinLeft + iconLink.frame.maxX, y: date.frame.maxY + 2 , width: frame.width, height: 16))
        title.setTitle("Fuente del enlace", forState: UIControlState.Normal)
        title.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        title.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        title.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        addSubview(title)
        
        subtitle = UILabel(frame: CGRect(x: paddinLeft + iconLink.frame.maxX, y: title.frame.maxY + 2, width: frame.width - ((paddinLeft*2)+iconLink.frame.maxX), height: 13))
        subtitle.text = "Descripción del enlace"
        subtitle.font = UIFont(name: "Roboto-Italic", size: 12)
        subtitle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        subtitle.numberOfLines = 1
        subtitle.textColor = UIColor.orangeYI()
        addSubview(subtitle)
        
        iconLink.center.y = title.center.y
        
        
        if type == 1 {
            actionPanel = Panel(frame: CGRectZero, data: NSMutableArray())
            actionPanel.center = CGPoint(x: frame.width/2, y: subtitle.frame.maxY + 20)
            addSubview(actionPanel)
            
            
            let line = UIBezierPath(rect: CGRect(x: 0, y: frame.maxY-1, width: frame.width, height: 0))
            _ = CAShapeLayer(layer: line)
            let staticLine = CAShapeLayer()
            staticLine.path = line.CGPath
            staticLine.strokeColor = UIColor.greyLight().CGColor
            self.layer.addSublayer(staticLine)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAsNew(){
        date.textColor = UIColor.greyLight()
        title.setTitleColor(UIColor.greyLight(), forState: UIControlState.Normal)
        subtitle.textColor = UIColor.greyLight()
        setIcon(UIImage(named: "Empty")!)
        date.text = "Fecha de publicación"
        title.setTitle("Fuente del enlace", forState: UIControlState.Normal)
        subtitle.text = "Descripción del enlace"
        iconLink.center.y = title.center.y
    }
    
    func setDates(dateStr:NSString!){
        date.textColor = UIColor.orangeYI()
        date.text = dateStr as String!
    }
    
    func setIcon(image:UIImage){
        if iconLink.isDescendantOfView(self){
            iconLink.removeFromSuperview()
        }
        iconLink = UIImageView(image: image)
        iconLink.frame.origin = CGPoint(x: paddinLeft,y: paddinLeft)
        addSubview(iconLink)
    }
    
}
