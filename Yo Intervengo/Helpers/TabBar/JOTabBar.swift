//
//  JOTabBar.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/30/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

@objc protocol JOTabBarDelegate{
    optional func tappedButton()
}

class JOTabBar: UIView {
    var delegate:JOTabBarDelegate!
    var buttons:NSMutableArray!
    var data:NSMutableArray!
    var container:UIView!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect, data:NSMutableArray) {
        super.init(frame: frame)
        self.data = data
        buttons = NSMutableArray()
        var counter = 0
        var w = (frame.size.width/CGFloat(data.count))
        let font = UIFont(name: "Roboto-Regular", size: 10)
        for button in data {
            var xAxis = CGFloat(counter)*w
            var but: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
            but.frame = CGRect(x: xAxis, y: 0, width: w, height: 55)
            but.backgroundColor = UIColor.whiteColor()
            but.layer.borderWidth = 1
            but.tag = counter+1
            but.titleLabel?.font = font
            var imageBtn = UIImage(named: (data.objectAtIndex(counter)[0] as String))
            but.setImage(imageBtn, forState: UIControlState.Normal)
            but.setTitle( (data.objectAtIndex(counter)[0] as String), forState: UIControlState.Normal)
        
            
            var spacing:CGFloat = 6
            var imageSize = but.imageView?.image?.size
            var title:NSString = "\(but.titleLabel?.text)"
            var titleSize = title.sizeWithAttributes([NSFontAttributeName: but.titleLabel?.font ?? UIFont.systemFontOfSize(100)])
        
            var size:CGSize = imageBtn?.size ?? CGSizeZero
            
            but.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
            but.titleEdgeInsets = UIEdgeInsetsMake(0.0, (-size.width) , -(size.height + spacing), 0.0)
            but.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), (titleSize.width-(size.width*1.7))/2 , 0.0, 0)
            
            
            but.layer.borderColor = UIColor.greyButtons().CGColor
            but.addTarget(self, action: Selector("buttonTapped:"), forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(but)
            counter++
            buttons.addObject(but)
        }
        setTab(1)
    }
    
    func buttonTapped(sender:UIButton!){
        setTab(sender.tag)
    }
    
    
    func setTab(index:Int){
        var counter = 1
        for button in buttons{
            (button as UIButton).backgroundColor = UIColor.whiteColor()
            /*if counter+1==index{
                var mask = CAShapeLayer()
                mask.path = (UIBezierPath(roundedRect: button.bounds, byRoundingCorners: UIRectCorner.BottomRight, cornerRadii:  CGSize(width: 5.0, height: 10.0))).CGPath
                button.layer.mask = mask
            }
            
            if counter-1==index{
                var mask = CAShapeLayer()
                mask.path = (UIBezierPath(roundedRect: button.bounds, byRoundingCorners: UIRectCorner.BottomLeft, cornerRadii:  CGSize(width: 5.0, height: 10.0))).CGPath
                button.layer.mask = mask
            }*/
            (button as UIButton).layer.borderColor = UIColor.greyButtons().CGColor
            (button as UIButton).tintColor = UIColor.greyDark()
            if counter==index{
                if (container?.isDescendantOfView(self) != nil){
                  container.removeFromSuperview()
                }
                (button as UIButton).layer.borderColor = UIColor.clearColor().CGColor
                (button as UIButton).tintColor = UIColor.orangeColor()
                container = self.data.objectAtIndex(index-1)[1] as UIView
                container.frame = (self.data.objectAtIndex(index-1)[1] as UIView).frame
                container.frame.origin = CGPoint(x: 0, y: 55)
                self.frame = CGRect(x: 0, y: self.frame.origin.y, width: 320, height: container.frame.maxY)
                self.addSubview(container)
                var pop = POPSpringAnimation(propertyNamed: kPOPViewFrame)
                pop.toValue = NSValue(CGRect: CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.size.width, height: container.frame.height+55)))
                self.pop_addAnimation(pop, forKey: "Increase")
                self.delegate?.tappedButton!()
            }
            counter++
        }
    }
    
}
