//
//  SelectReportTypeViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/8/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import UIKit

public class SelectReportTypeViewController: UIViewController,LNERadialMenuDelegate,LNERadialMenuDataSource {
    private var btnClose:UIButton!
    private var thisMenu:LNERadialMenu!
    
    var lbl:UILabel!
    
    public override func viewDidLoad() {
        self.view.backgroundColor = UIColor.clearColor()
        let blurView   = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        blurView.frame = self.view.bounds
        self.view.addSubview(blurView)
        
        
        let point = CGPointMake(self.view.frame.size.width - 30, self.view.frame.size.height - 30)
        
        thisMenu = LNERadialMenu(fromPoint: point, withDataSource: self, andDelegate: self,withFrame: self.view.frame, andLabels:true)
        self.view.addSubview(thisMenu)
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.test(_:)), name: "testTest", object: nil)
        
        
        lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lbl)
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[lbl]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["lbl" : lbl]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[lbl]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["lbl" : lbl]))
        
    }
    
    func test(notification:NSNotification){
        if let content = notification.object{
            lbl.text = content as? String
            lbl.sizeToFit()
        }
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        thisMenu.showMenu()
    }
    
    public func radialMenu(radialMenu: LNERadialMenu!, didSelectButton button: UIButton!) {
        //        step                       = 2
        //        btnCategoty                = UIButton(frame: button.frame)
        //        btnCategoty.center         = btnClose.center
        //        btnCategoty.setBackgroundImage(button.backgroundImageForState(.Normal), forState: UIControlState.Normal)
        //        btnCategoty.tag            = button.tag
        //        btnCategoty.addTarget(self, action: #selector(JOaddReport.goBack(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        //        self.addSubview(btnCategoty)
        //        let pop                    = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        //        pop.toValue                = NSValue(CGPoint: CGPoint(x: self.frame.size.width-100, y: btnClose.center.y))
        //        _                          = button.titleLabel?.text?.utf16
        //        let t                      = Int(btnCategoty.frame.origin.x) - 265
        //        lblIndicator               = UILabel(frame: CGRect(x: t, y: (Int(btnCategoty.center.y) - 20), width: 200, height: 40))
        //        str1                       = button.titleLabel?.text
        //        lblIndicator.numberOfLines = 2
        //        lblIndicator.alpha         = 0
        //        lblIndicator.text          = str1
        //        lblIndicator.textColor     = UIColor.addThemeContrast()
        //        lblIndicator.textAlignment = .Right
        //        lblIndicator.font = UIFont(name: "Roboto-Regular", size: 15)
        //        self.addSubview(lblIndicator)
        //        let pop2 = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        //        pop2.duration = 2
        //        pop2.toValue = 1
        //        lblIndicator.pop_addAnimation(pop2, forKey: "Test2")
        //        btnCategoty.pop_addAnimation(pop, forKey: "TEST")
        //        showMenu(2, atPoint: CGPointZero)
        radialMenu.closeMenu()
    }
    
    public func radialMenu(radialMenu: LNERadialMenu!, closingMenu close: Bool) {
        let view2 = SelectCategoryViewController()
        view2.view.backgroundColor = UIColor.clearColor()
        view2.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        view2.modalTransitionStyle   = .CrossDissolve
        self.presentViewController(view2, animated: true, completion: nil)
    }
    
    public func numberOfButtonsForRadialMenu(radialMenu: LNERadialMenu!) -> Int {
        return 2
    }
    
    public func radiusLenghtForRadialMenu(radialMenu: LNERadialMenu!) -> CGFloat {
        return 60
    }
    
    public func radialMenu(radialMenu: LNERadialMenu!, elementAtIndex index: Int) -> UIButton! {
        let element = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
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
    
    public func viewForCenterOfRadialMenu(radialMenu: LNERadialMenu!) -> UIView! {
        let centerView = UIView(frame: CGRect(x: 0, y: 0, width: 190, height: 190))
        centerView.backgroundColor  = UIColor.blackColor().colorWithAlphaComponent(0.2)
        return centerView
    }
    
    public func radialMenu(radialMenu: LNERadialMenu!, customizationForRadialMenuView radialMenuView: UIView!) {
        let bgLayer = CALayer()
        bgLayer.cornerRadius = 5
        bgLayer.frame = CGRect(x: (radialMenu.radialMenuView.frame.size.width-10)/2, y: (radialMenu.radialMenuView.frame.size.width-10)/2, width: 10, height: 10)
        bgLayer.backgroundColor = UIColor.addThemeContrast().colorWithAlphaComponent(0.2).CGColor
        radialMenu.radialMenuView.layer.insertSublayer(bgLayer, atIndex: 0)
        
        let bgLayer2 = CALayer()
        bgLayer2.cornerRadius = 2
        bgLayer2.frame = CGRect(x: (radialMenu.radialMenuView.frame.size.width-4)/2, y: (radialMenu.radialMenuView.frame.size.width-4)/2, width: 4, height: 4)
        bgLayer2.backgroundColor = UIColor.addThemeContrast().colorWithAlphaComponent(0.4).CGColor
        radialMenu.radialMenuView.layer.insertSublayer(bgLayer2, atIndex: 0)
    }
    
    public func canDragRadialMenu(radialMenu: LNERadialMenu!) -> Bool {
        return false
    }
}
