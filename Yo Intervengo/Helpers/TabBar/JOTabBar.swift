//
//  JOTabBar.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/30/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit
import pop

@objc protocol JOTabBarDelegate{
    optional func tappedButton()
}

class JOTabBar: UIView {
    var delegate:JOTabBarDelegate!
    var buttons:NSMutableArray!
    var data:NSMutableArray!
    var container:UIView!
    var actual:Int!
    var colorView:UIColor!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, data:NSMutableArray, color: UIColor) {
        super.init(frame: frame)
        self.data = data
        buttons = NSMutableArray()
        colorView = color
        let counter = 0
        let w = (frame.size.width/CGFloat(data.count))
        _ = UIFont(name: "Roboto-Regular", size: 10)
        for _ in data {
            let xAxis = CGFloat(counter)*w
            let but: UIButton = UIButton(type: UIButtonType.System)
            but.frame = CGRect(x: xAxis, y: 0, width: w, height: 55)
            but.backgroundColor = UIColor.whiteColor()
            but.layer.borderWidth = 1
            but.tag = counter+1
            //            but.titleLabel?.font = font
            //            let imageBtn = UIImage(named: (data.objectAtIndex(counter)[0] as! String))
            //            but.setImage(imageBtn, forState: UIControlState.Normal)
            //            but.setTitle( (data.objectAtIndex(counter)[0] as! String), forState: UIControlState.Normal)
            //            
            //            let spacing:CGFloat = 6
            //            _ = but.imageView?.image?.size
            //            let title:NSString = "\(but.titleLabel?.text)"
            //            let titleSize = title.sizeWithAttributes([NSFontAttributeName: but.titleLabel?.font ?? UIFont.systemFontOfSize(100)])
            //            
            //            //            let size:CGSize = imageBtn?.size ?? CGSizeZero
            //            
            //            but.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
            //            but.titleEdgeInsets = UIEdgeInsetsMake(0.0, (-size.width) , -(size.height + spacing), 0.0)
            //            but.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), (titleSize.width-(size.width*1.7))/2 , 0.0, 0)
            //            
            //            but.layer.borderColor = UIColor.greyButtons().CGColor
            //            but.addTarget(self, action: #selector(JOTabBar.buttonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            //            self.addSubview(but)
            //            counter += 1
            //            buttons.addObject(but)
        }
        setTab(1)
    }
    
    func buttonTapped(sender:UIButton!){
        setTab(sender.tag)
    }
    
    func getActHelper() ->UIButton{
        let returnBtn = UIButton()
        switch(actual){
        case 1: returnBtn.tag = 0
        case 2: returnBtn.tag = 0
        case 3: returnBtn.setImage(UIImage(named: "linkHelper"), forState: UIControlState.Normal)
        returnBtn.tag = 1
        case 4: returnBtn.setImage(UIImage(named: "linkHelper"), forState: UIControlState.Normal)
        returnBtn.tag = 2
        default: returnBtn.tag = 0
        }
        
        return returnBtn
    }
    
    func setTab(index:Int){
        var counter = 1
        actual = index
        for button in buttons{
            (button as! UIButton).backgroundColor = UIColor.whiteColor()
            /*if counter+1==index{
             var mask = CAShapeLayer()
             mask.path = (UIBezierPath(roundedRect: button.bounds, byRoundingCorners: UIRectCorner.BottomRight, cornerRadii:  CGSize(width: 5.0, height: 10.0))).CGPath
             button.layer.mask = mask
             }
             
             if counter-1==index{
             var mask = CAShapeLayer()
             mask.path = (UIBezierPath(roundedRect: button.bounds, byRoundingCorners: UIRectCorner.BottomLeft, cornerRadii:  CGSize(width: 5.0, height: 10.0))).CGPath
             button.layer.mask = mask
             //             }*/
            //            (button as! UIButton).layer.borderColor = UIColor.greyButtons().CGColor
            //            (button as! UIButton).tintColor = UIColor.greyDark()
            //            if counter==index{
            //                if (container?.isDescendantOfView(self) != nil){
            //                    container.removeFromSuperview()
            //                }
            //                (button as! UIButton).layer.borderColor = UIColor.clearColor().CGColor
            //                (button as! UIButton).tintColor = colorView
            //                container = self.data.objectAtIndex(index-1)[1] as! UIView
            //                container.frame = (self.data.objectAtIndex(index-1)[1] as! UIView).frame
            //                container.frame.origin = CGPoint(x: 0, y: 55)
            //                self.frame = CGRect(x: 0, y: self.frame.origin.y, width: 320, height: container.frame.maxY)
            //                self.addSubview(container)
            //                let pop = POPSpringAnimation(propertyNamed: kPOPViewFrame)
            //                pop.toValue = NSValue(CGRect: CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.size.width, height: container.frame.height+55)))
            //                self.pop_addAnimation(pop, forKey: "Increase")
            //                self.delegate?.tappedButton!()
            //                
            //            }
            counter += 1
        }
    }
    
}
