//
//  LeftMenu.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/14/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import Foundation
import UIKit

@objc protocol LeftMenuDelegate{
    optional func goTo(index:Int)
}

class LeftMenu: UIView{
    var opened = false
    var btnRep:UIButton!
    var btnWiki:UIButton!
    var btnStat:UIButton!
    var btnProf:UIButton!
    var btnSett:UIButton!
    var delegate:LeftMenuDelegate?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red:0.200, green:0.200, blue:0.200, alpha: 0.95)
        let spacer = 10
        btnRep  = UIButton(frame: CGRect(x: 20, y: 76, width: 120, height: 26))
        btnWiki = UIButton(frame: CGRect(x: 20, y: btnRep.frame.maxY+10, width: 120, height: 26))
        btnStat = UIButton(frame: CGRect(x: 20, y: btnWiki.frame.maxY+10, width: 120, height: 26))
        btnProf = UIButton(frame: CGRect(x: 20, y: btnStat.frame.maxY+10, width: 120, height: 26))
        btnSett = UIButton(frame: CGRect(x: 20, y: btnProf.frame.maxY+10, width: 120, height: 26))
        
        btnRep.setTitle("...REPORTES", forState: UIControlState.Normal)
        btnWiki.setTitle("ACERCA DE", forState: UIControlState.Normal)
        btnStat.setTitle("ESTADÍSTICAS", forState: UIControlState.Normal)
        btnProf.setTitle("PERFIL", forState: UIControlState.Normal)
        btnSett.setTitle("ACERCA DE", forState: UIControlState.Normal)
        
        btnRep.setTitleColor(UIColor(red:0.898, green:0.898, blue:0.898, alpha: 1), forState: UIControlState.Normal)
        btnWiki.setTitleColor(UIColor(red:0.898, green:0.898, blue:0.898, alpha: 1), forState: UIControlState.Normal)
        btnStat.setTitleColor(UIColor(red:0.898, green:0.898, blue:0.898, alpha: 1), forState: UIControlState.Normal)
        btnProf.setTitleColor(UIColor(red:0.898, green:0.898, blue:0.898, alpha: 1), forState: UIControlState.Normal)
        btnSett.setTitleColor(UIColor(red:0.898, green:0.898, blue:0.898, alpha: 1), forState: UIControlState.Normal)
        
        let fontSize = CGFloat(15.0)
        let fontName = "Roboto-Light"
        
        btnRep.titleLabel?.font  = UIFont(name: fontName, size: fontSize)
        btnWiki.titleLabel?.font = UIFont(name: fontName, size: fontSize)
        btnStat.titleLabel?.font = UIFont(name: fontName, size: fontSize)
        btnProf.titleLabel?.font = UIFont(name: fontName, size: fontSize)
        btnSett.titleLabel?.font = UIFont(name: fontName, size: fontSize)
        
        btnRep.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        btnWiki.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        btnStat.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        btnProf.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        btnSett.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        
        btnRep.tag  = 3330;
        btnWiki.tag = 3331;
        btnStat.tag = 3332;
        btnProf.tag = 3333;
        btnSett.tag = 3334;
        
        btnRep.addTarget(self,  action: "goBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        btnWiki.addTarget(self, action: "goBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        btnStat.addTarget(self, action: "goBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        btnProf.addTarget(self, action: "goBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        btnSett.addTarget(self, action: "goBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(btnRep)
        self.addSubview(btnWiki)
        /*self.addSubview(btnStat)
        self.addSubview(btnProf)
        self.addSubview(btnSett)*/
        
        opened = false
    }
    
    func interact(){
        var spAn = POPBasicAnimation(propertyNamed:kPOPViewCenter)
        spAn.timingFunction =  CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        if opened{
            spAn.toValue = NSValue(CGPoint: CGPointMake(-100, self.center.y))
        }
        else{
            spAn.toValue = NSValue(CGPoint: CGPointMake(100, self.center.y))
            
        }
        opened = !opened
        self.pop_addAnimation(spAn, forKey: "center")
    }
    
    func setColor(idBtn:Int){
        btnRep.setTitleColor(UIColor(red:0.898, green:0.898, blue:0.898, alpha: 1), forState: UIControlState.Normal)
        btnWiki.setTitleColor(UIColor(red:0.898, green:0.898, blue:0.898, alpha: 1), forState: UIControlState.Normal)
        btnStat.setTitleColor(UIColor(red:0.898, green:0.898, blue:0.898, alpha: 1), forState: UIControlState.Normal)
        btnProf.setTitleColor(UIColor(red:0.898, green:0.898, blue:0.898, alpha: 1), forState: UIControlState.Normal)
        btnSett.setTitleColor(UIColor(red:0.898, green:0.898, blue:0.898, alpha: 1), forState: UIControlState.Normal)
        
        //sender.setTitleColor( UIColor.orangeYI() , forState: UIControlState.Normal)
        
        (self.viewWithTag(idBtn) as! UIButton).setTitleColor(UIColor(red:0.761, green:0.286, blue:0.000, alpha: 1), forState: UIControlState.Normal)
    }
    
    func goBtn(sender:UIButton){
        setColor(sender.tag)
        self.delegate!.goTo!(sender.tag - 3330)
    }
    
}
