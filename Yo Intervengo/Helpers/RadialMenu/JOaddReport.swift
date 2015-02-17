//
//  JOaddReport.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/24/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class JOaddReport: UIView,LNERadialMenuDataSource,LNERadialMenuDelegate,JOSideBarMenuDelegate,JOCentralMenuDelegate {
    // MARK: -VAR DEFFINITION
    var step = 0
    let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
    var btnClose:UIButton!
    var btnCategoty:UIButton!
    var btnSubcategory:UIButton!
    var lblIndicator:UILabel!
    var labels:Int!
    var this:JOSideBarMenu!
    var this2:JOCentralMenu!
    
    var sideData:NSMutableArray!
    var conn:Connection!
    
    var str1:String!
    var str2:String!
    var str3:String!
    
    
    // MARK: -INIT
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, bttnClose:UIButton, labels:Int) {
        super.init(frame: frame)
        step = 1
        
        btnClose = UIButton(frame: bttnClose.frame)
        btnClose.center = bttnClose.center
        self.labels = labels
        btnClose.setImage(bttnClose.backgroundImageForState(UIControlState.Normal), forState: UIControlState.Normal)
        btnClose.addTarget(self, action: Selector("close"), forControlEvents: UIControlEvents.TouchUpInside)
        
        conn = Connection()
        
        var blurView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        blurView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        self.addSubview(blurView)
        self.addSubview(btnClose)
    }
    
    func showMenu(step:Int, atPoint point:CGPoint){
        switch (step){
        case 1:
            var an = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
            an.toValue = -0.75
            an.springBounciness = 10
            btnClose.layer.pop_addAnimation(an, forKey: "Rotate")
            var thisMenu = LNERadialMenu(fromPoint: point, withDataSource: self, andDelegate: self,withFrame: self.frame, andLabels:Boolean(labels))
                thisMenu.radialMenuIdentifier = "show"
                self.insertSubview(thisMenu, belowSubview: btnClose)
                thisMenu.showMenu()
        case 2:
                sideData = conn.getCategories(lblIndicator.text == "REPORTE")
                this = JOSideBarMenu(frame: CGRectMake(0, 0, 320, min(350, self.frame.height - (100 + btnClose.frame.height)))  , data: sideData)
                this.frame.origin = CGPoint(x: 0, y: (frame.height - btnClose.frame.height)-this.frame.height)
                this.delegate = self
                self.addSubview(this)
        case 3:
                var d = NSMutableArray()
                //d.addObject(["Image":"Solicitud","Text":"Servicio públicos"])
                var t = (self.frame.size.height-450)/2
                this2 = JOCentralMenu(frame: CGRectMake(0, t, 320, 400) , data: d)
                this2.delegate = self
                self.insertSubview(this2, belowSubview: btnCategoty)
        default: println("Default")
        }
    }
    
    // MARK: -RADIAL MENU DELEGATE ::STEP 2
    func radialMenu(radialMenu: LNERadialMenu!, didSelectButton button: UIButton!) {
        step = 2
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
        str1 = button.titleLabel?.text
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
        btnCategoty.pop_addAnimation(pop, forKey: "TEST")
        showMenu(2, atPoint: CGPointZero)
        radialMenu.closeMenu()
    }
    
    func radialMenu(radialMenu: LNERadialMenu!, closingMenu close: Boolean) {
        //closeMenu()
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
    
    func viewForCenterOfRadialMenu(radialMenu: LNERadialMenu!) -> UIView! {
        var centerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 190, height: 190))
        centerView.backgroundColor  = UIColor.blackColor().colorWithAlphaComponent(0.2)
        return centerView
    }
    
    func radialMenu(radialMenu: LNERadialMenu!, customizationForRadialMenuView radialMenuView: UIView!) {
        var bgLayer:CALayer = CALayer()
        bgLayer.cornerRadius = 5
        bgLayer.frame = CGRect(x: (radialMenu.radialMenuView.frame.size.width-10)/2, y: (radialMenu.radialMenuView.frame.size.width-10)/2, width: 10, height: 10)
        bgLayer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2).CGColor
        radialMenu.radialMenuView.layer.insertSublayer(bgLayer, atIndex: 0)
        
        var bgLayer2:CALayer = CALayer()
        bgLayer2.cornerRadius = 2
        bgLayer2.frame = CGRect(x: (radialMenu.radialMenuView.frame.size.width-4)/2, y: (radialMenu.radialMenuView.frame.size.width-4)/2, width: 4, height: 4)
        bgLayer2.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.4).CGColor
        radialMenu.radialMenuView.layer.insertSublayer(bgLayer2, atIndex: 0)
    }
    
    func canDragRadialMenu(radialMenu: LNERadialMenu!) -> Bool {
        return false
    }
    
    // MARK: -SIDE BAR DELEGATE  ::STEP 3
    
    func buttoTapped(button:UIImageView!,withSideBar sideBar:JOSideBarMenu,label:String){
        step = 3
        sideBar.closeSideView()
        str2 = label
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
        lblIndicator.text = str2
        var pop2 = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        pop2.toValue = NSValue(CGPoint: CGPoint(x: lblIndicator.center.x-25, y: btnClose.center.y))
        lblIndicator.pop_addAnimation(pop2, forKey: "TEST3")
        var pop3 = POPSpringAnimation(propertyNamed: kPOPViewSize)
        pop3.toValue = NSValue(CGSize: CGSize(width: 100, height: lblIndicator.frame.size.height))
        lblIndicator.pop_addAnimation(pop3, forKey: "TEST4")
    }
    
    // MARK: -SUBCATEGORY DELEGATE ::STEP 4
    func buttoTapped(button: UIButton!, withCentralBar sideBar: JOCentralMenu) {
        println("Creando nuevo reporte")
    }
    
    
    // MARK: -BACK METHODS
    func goBack(sender:UIButton!){
        println("Estaba en \(step)")
        switch step{
            case 2:
                labels = 1
                self.showMenu(1, atPoint: btnClose.center)
                btnCategoty.removeFromSuperview()
                if (btnSubcategory != nil){
                    btnSubcategory.removeFromSuperview()
                    btnSubcategory = nil
                }
                lblIndicator.removeFromSuperview()
                this.removeFromSuperview()
                if (this2 != nil){
                    this2.removeFromSuperview()
                    this2 = nil
                }
            case 3:
                goLbl(2)
                self.showMenu(2, atPoint: CGPointZero)
                btnSubcategory.removeFromSuperview()
                this2.removeFromSuperview()
            default: println("Default")
        }
        step--
    }
    
    func goLbl(step:Int){
        switch step{
        case 2:
            lblIndicator.text = str1
            var pop3 = POPSpringAnimation(propertyNamed: kPOPViewSize)
            pop3.toValue = NSValue(CGSize: CGSize(width: 200, height: lblIndicator.frame.size.height))
            lblIndicator.pop_addAnimation(pop3, forKey: "TEST4")
            
            var pop2 = POPSpringAnimation(propertyNamed: kPOPViewCenter)
            pop2.toValue = NSValue(CGPoint: CGPoint(x: lblIndicator.center.x+25, y: btnClose.center.y))
            lblIndicator.pop_addAnimation(pop2, forKey: "TEST3")
        case 3:
            lblIndicator.text = str2
        default: println("Default")
        }
    }
    
    
    func close(){
        var an = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        an.toValue = 0
        an.springBounciness = 10
        btnClose.layer.pop_addAnimation(an, forKey: "Rotate")
        UIView.animateWithDuration(1.0, delay: 0, options: .CurveEaseOut, animations: {
            self.alpha = 0
            }, completion: { finished in
                self.removeFromSuperview()
        })
    }
    
    
}
