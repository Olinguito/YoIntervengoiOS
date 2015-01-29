//
//  JOaddReport.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/24/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class JOaddReport: UIView,LNERadialMenuDataSource,LNERadialMenuDelegate,JOSideBarMenuDelegate {
    var step = 0
    let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
    var btnClose:UIButton!
    var btnCategoty:UIButton!
    var btnSubcategory:UIButton!
    var lblIndicator:UILabel!
    
    var this:JOSideBarMenu!
    var this2:JOCentralMenu!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, bttnClose:UIButton) {
        super.init(frame: frame)
        btnClose = UIButton(frame: bttnClose.frame)
        btnClose.center = bttnClose.center
        btnClose.setBackgroundImage(bttnClose.backgroundImageForState(UIControlState.Normal), forState: UIControlState.Normal)
        /*let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
        blurView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        blurView.alpha = 1
        var lay = CALayer()
        lay.frame = frame
        lay.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.1).CGColor
        blurView.layer.insertSublayer(lay, atIndex: 0)*/
        var blurView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        blurView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.9)
        self.addSubview(blurView)
        self.addSubview(btnClose)
    }
    
    func showMenu(step:Int, atPoint point:CGPoint){
        switch (step){
        case 1:
            var thisMenu = LNERadialMenu(fromPoint: point, withDataSource: self, andDelegate: self,withFrame: self.frame, andLabels:Boolean(0))
            thisMenu.radialMenuIdentifier = "show"
            self.addSubview(thisMenu)
            thisMenu.showMenu()
        case 2: println(2)
                var d = NSMutableArray()
                //d.addObject(["Image":"Solicitud","Text":"Servicio públicos"])
                this = JOSideBarMenu(frame: CGRectMake(0, 80, 320, 355) , data: d)
                this.delegate = self
                self.insertSubview(this, belowSubview: btnCategoty)
        case 3: println(2)
                var d = NSMutableArray()
                //d.addObject(["Image":"Solicitud","Text":"Servicio públicos"])
                var t = (self.frame.size.height-450)/2
                this2 = JOCentralMenu(frame: CGRectMake(0, t, 320, 400) , data: d)
                //this2.delegate = self
                self.insertSubview(this2, belowSubview: btnCategoty)
        default: println("Default")
        }
    }
    
    // SUBCATEGORY TAPPED
    
    
    
    // SIDE BAR DELEGATE
    
    func buttoTapped(button:UIImageView!,withSideBar sideBar:JOSideBarMenu,label:String){
        sideBar.closeSideView()
        
        showMenu(3, atPoint: CGPointZero)
        
        btnSubcategory = UIButton(frame: CGRectMake(0, 0, btnCategoty.frame.size.width - 10, btnCategoty.frame.height - 10))
        btnSubcategory.tag = 2
        btnSubcategory.center = btnCategoty.center
        btnSubcategory.setBackgroundImage(button.image, forState: UIControlState.Normal)
        btnSubcategory.addTarget(self, action: Selector("goBack:"), forControlEvents: UIControlEvents.TouchUpInside)
        //btnSubcategory.setBackgroundImage(UIImage(named: "repo"), forState: UIControlState.Normal)
        self.addSubview(btnSubcategory)
        var pop = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        pop.toValue = NSValue(CGPoint: CGPoint(x: self.frame.size.width-164, y: btnClose.center.y))
        btnSubcategory.pop_addAnimation(pop, forKey: "TEST2")
        lblIndicator.text = label
        var pop2 = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        pop2.toValue = NSValue(CGPoint: CGPoint(x: lblIndicator.center.x-25, y: btnClose.center.y))
        lblIndicator.pop_addAnimation(pop2, forKey: "TEST3")
        
        
        var pop3 = POPSpringAnimation(propertyNamed: kPOPViewSize)
        pop3.toValue = NSValue(CGSize: CGSize(width: 100, height: lblIndicator.frame.size.height))
        lblIndicator.pop_addAnimation(pop3, forKey: "TEST4")
    }
    
    // READIAL MENU DELEGATE
    func radialMenu(radialMenu: LNERadialMenu!, closingMenu close: Boolean) {
        closeMenu()
    }
    
    func closeMenu(){
        var an = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        an.toValue = 0.75
        an.springBounciness = 10
        btnClose.layer.pop_addAnimation(an, forKey: "Rotate")
    }
    
    func numberOfButtonsForRadialMenu(radialMenu: LNERadialMenu!) -> Int {
        return 2
    }
    
    func radiusLenghtForRadialMenu(radialMenu: LNERadialMenu!) -> CGFloat {
        return 60
    }
    
    func radialMenu(radialMenu: LNERadialMenu!, elementAtIndex index: Int) -> UIButton! {
        var element : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        switch index{
        case 0: element.titleLabel?.text = "REPORTE"
        element.setBackgroundImage(UIImage(named: "repo"), forState: UIControlState.Normal)
        case 1: element.titleLabel?.text = "SOLICITUD"
        element.setBackgroundImage(UIImage(named: "solicitud"), forState: UIControlState.Normal)
        default:element.titleLabel?.text = "SOLICITUD"
        element.setBackgroundImage(UIImage(named: "solicitud"), forState: UIControlState.Normal)
        }
        element.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
        return element
    }
    
    func radialMenu(radialMenu: LNERadialMenu!, didSelectButton button: UIButton!) {
        btnCategoty = UIButton(frame: button.frame)
        btnCategoty.center = btnClose.center
        btnCategoty.setBackgroundImage(button.backgroundImageForState(UIControlState.Normal), forState: UIControlState.Normal)
        btnCategoty.tag = 1
        btnCategoty.addTarget(self, action: Selector("goBack:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(btnCategoty)
        var pop = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        pop.toValue = NSValue(CGPoint: CGPoint(x: self.frame.size.width-100, y: btnClose.center.y))
        var wl = button.titleLabel?.text?.utf16Count
        var t = Int(btnCategoty.frame.origin.x) - 265
        lblIndicator = UILabel(frame: CGRect(x: t, y: (Int(btnCategoty.center.y) - 20), width: 200, height: 40))
        lblIndicator.numberOfLines = 2
        lblIndicator.text = button.titleLabel?.text
        lblIndicator.textColor = UIColor.whiteColor()
        lblIndicator.textAlignment = NSTextAlignment.Right
        lblIndicator.font = UIFont(name: "Roboto-Regular", size: 15)
        self.addSubview(lblIndicator)
        btnCategoty.pop_addAnimation(pop, forKey: "TEST")
        showMenu(2, atPoint: CGPointZero)
        radialMenu.closeMenu()
    }
    
    func viewForCenterOfRadialMenu(radialMenu: LNERadialMenu!) -> UIView! {
        var centerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 190, height: 190))
        centerView.backgroundColor  = UIColor.blackColor().colorWithAlphaComponent(0.2)
        return centerView
    }
    
    func radialMenu(radialMenu: LNERadialMenu!, customizationForRadialMenuView radialMenuView: UIView!) {
        var bgLayer:CALayer = CALayer()
        bgLayer.backgroundColor = UIColor.orangeColor().CGColor
        radialMenu.layer.insertSublayer(bgLayer, atIndex: 0)
    }
    
    func canDragRadialMenu(radialMenu: LNERadialMenu!) -> Bool {
        return false
    }
    
    
    //BACK METHODS
    
    func goBack(sender:UIButton!){
        switch sender.tag{
            case 1:
                self.showMenu(1, atPoint: btnClose.center)
                /*btnCategoty.removeFromSuperview()
                btnSubcategory.removeFromSuperview()
                lblIndicator.removeFromSuperview()
                this.removeFromSuperview()
                this2.removeFromSuperview()*/
            case 2:
                self.showMenu(2, atPoint: CGPointZero)
            /*
            btnCategoty.removeFromSuperview()
            lblIndicator.removeFromSuperview()
            this2.removeFromSuperview()*/
            default: println("Default")
        }
    }
    
}
