//
//  JOaddReport.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/24/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class JOaddReport: UIView,LNERadialMenuDataSource,LNERadialMenuDelegate {
    var step = 0
    let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
    var btnCategoty:UIButton!
    var btnSubcategory:UIButton!
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
        blurView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        blurView.alpha = 1
        var lay = CALayer()
        lay.frame = frame
        lay.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.1).CGColor
        blurView.layer.insertSublayer(lay, atIndex: 0)
        self.addSubview(blurView)
        
    }
    
    
    func showMenu(step:Int, atPoint point:CGPoint){
        switch (step){
        case 1: var thisMenu = LNERadialMenu(fromPoint: point, withDataSource: self, andDelegate: self, withFrame: self.frame, andLabels:Boolean(0))
                thisMenu.radialMenuIdentifier = "show"
                self.addSubview(thisMenu)
                thisMenu.showMenu()
        case 2: println(2)
                var d = NSMutableArray()
                //d.addObject(["Image":"Solicitud","Text":"Servicio públicos"])
                var this = JOSideBarMenu(frame: CGRectMake(0, 90, 320, 355) , data: d)
                //self.addSubview(this)
                self.insertSubview(this, belowSubview: btnCategoty)
        
        default: println("Default")
        }
    }
    
    
    
    // READIAL MENU DELEGATE
    
    func radialMenu(radialMenu: LNERadialMenu!, closingMenu close: Boolean) {
        closeMenu()
    }
    
    func closeMenu(){
        var an = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        an.toValue = 0.75
        an.springBounciness = 10
        //btnReport.layer.pop_addAnimation(an, forKey: "Rotate")
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
        btnCategoty.center = radialMenu.center
        btnCategoty.setBackgroundImage(button.backgroundImageForState(UIControlState.Normal), forState: UIControlState.Normal)
        self.addSubview(btnCategoty)
        var pop = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        pop.toValue = NSValue(CGPoint: CGPoint(x: 220, y: 535))
        btnCategoty.pop_addAnimation(pop, forKey: "TEST")
        
        
        println("Fuck Yeahh \(button.tag)")
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


}
