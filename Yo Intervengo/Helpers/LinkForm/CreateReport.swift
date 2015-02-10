//
//  CreateReport.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/9/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class CreateReport: UIView,JOSideBarMenuDelegate,UITextFieldDelegate {

    var step = 0
    let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
    var btnClose:UIButton!
    var btnCategoty:UIButton!
    var btnSubcategory:UIButton!
    var lblIndicator:UILabel!
    var labels:Int!
    var this:JOSideBarMenu!
    var this2:JOCentralMenu!
    
    
    var str1:String!
    var str2:String!
    var str3:String!
    var card:LinkComponent!
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, bttnClose:UIButton) {
        super.init(frame: frame)
        btnClose = UIButton(frame: bttnClose.frame)
        btnClose.center = bttnClose.center
        btnClose.setImage(UIImage(named: "mas"), forState: UIControlState.Normal)
        btnClose.addTarget(self, action: Selector("close"), forControlEvents: UIControlEvents.TouchUpInside)
        
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
        blurView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        blurView.alpha = 1
        var lay = CALayer()
        lay.frame = frame
        lay.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.1).CGColor
        blurView.layer.insertSublayer(lay, atIndex: 0)
    
        self.addSubview(blurView)
        self.addSubview(btnClose)
        showMenu(1, atPoint: CGPointZero)
        
        
        card = LinkComponent(type: 2)
        card.center = CGPoint(x: frame.size.width/2 , y: (card.frame.height/2) + 25)
        card.setAsNew()
        self.addSubview(card)
        
    }
    
    func showMenu(step:Int, atPoint point:CGPoint){
        switch (step){
        case 1:
            var an = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
            an.toValue = -0.75
            an.springBounciness = 10
            btnClose.layer.pop_addAnimation(an, forKey: "Rotate")
            
            var an2 = POPSpringAnimation(propertyNamed: kPOPViewSize)
            an2.toValue = NSValue(CGSize: CGSize(width: 50, height: 50))
            an2.springBounciness = 10
            btnClose.layer.pop_addAnimation(an2, forKey: "size")
            
            var d = NSMutableArray()
            this = JOSideBarMenu(frame: CGRectMake(0, 0, 320, min(350, self.frame.height - (100 + btnClose.frame.height)))  , data: d)
            this.frame.origin = CGPoint(x: 0, y: (frame.height - btnClose.frame.height)-this.frame.height)
            this.delegate = self
            //self.insertSubview(this, belowSubview: btnCategoty)
            self.addSubview(this)
        case 2: println(2)
        case 3: println(2)
        default: println("Default")
        }
    }
    
    
    
    // SIDE BAR DELEGATE
    
    func buttoTapped(button:UIImageView!,withSideBar sideBar:JOSideBarMenu,label:String){
        sideBar.closeSideView()

        
        card.setIcon(UIImage(named: "Note")!)
        
        btnCategoty = UIButton(frame: button.frame)
        btnCategoty.center = btnClose.center
        btnCategoty.setBackgroundImage(button.image, forState: UIControlState.Normal)
        btnCategoty.tag = 1
        btnCategoty.addTarget(self, action: Selector("goBack:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(btnCategoty)
        
        var pop = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        pop.toValue = NSValue(CGPoint: CGPoint(x: btnClose.frame.minX - 40, y: btnClose.center.y))
        var t = Int(btnCategoty.frame.origin.x) - 265
        lblIndicator = UILabel(frame: CGRect(x: t, y: (Int(btnCategoty.center.y) - 20), width: 200, height: 40))
        
        var pot = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        pot.toValue = NSValue(CGPoint: CGPoint(x: btnClose.frame.minX-20, y: btnClose.center.y))
        btnCategoty.pop_addAnimation(pot, forKey: "TEST")
        
        lblIndicator = UILabel(frame: CGRect(x: 20, y: 300, width: 200, height: 40))
        lblIndicator.center = CGPoint(x: btnCategoty.frame.minX-165, y: btnCategoty.center.y)
        str1 = label
        lblIndicator.numberOfLines = 2
        lblIndicator.alpha = 0
        lblIndicator.text = str1
        lblIndicator.textColor = UIColor.whiteColor()
        lblIndicator.textAlignment = NSTextAlignment.Right
        lblIndicator.font = UIFont(name: "Roboto-Regular", size: 15)
        self.addSubview(lblIndicator)
        
        var pop2 = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        pop2.duration = 2
        pop2.toValue = 1
        lblIndicator.pop_addAnimation(pop2, forKey: "Test2")

        showMenu(3, atPoint: CGPointZero)
    }

    func close(){
        var an = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        an.toValue = 0
        an.springBounciness = 10
        btnClose.layer.pop_addAnimation(an, forKey: "Rotate")
        var an2 = POPSpringAnimation(propertyNamed: kPOPViewSize)
        an2.toValue = NSValue(CGSize: CGSize(width: 71, height: 70))
        an2.springBounciness = 10
        btnClose.layer.pop_addAnimation(an2, forKey: "size")
        UIView.animateWithDuration(1.0, delay: 0, options: .CurveEaseOut, animations: {
            self.alpha = 0
            }, completion: { finished in
                self.removeFromSuperview()
        })
    }
    
    
    func goBack(sender:UIButton!){
        switch sender.tag{
            case 1:
                self.showMenu(1, atPoint: btnClose.center)
                card.setAsNew()
                btnCategoty.removeFromSuperview()
                lblIndicator.removeFromSuperview()
            default: println("Default")
        }
    }
    
}