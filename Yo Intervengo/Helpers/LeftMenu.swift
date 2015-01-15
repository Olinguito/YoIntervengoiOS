//
//  LeftMenu.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/14/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import Foundation
import UIKit


class LeftMenu: UIView{
    var opened = false
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red:0.200, green:0.200, blue:0.200, alpha: 0.95)
        let spacer = 10
        let btnRep  = UIButton(frame: CGRect(x: 20, y: 76, width: 120, height: 26))
        let btnWiki = UIButton(frame: CGRect(x: 20, y: btnRep.frame.maxY+10, width: 120, height: 26))
        let btnStat = UIButton(frame: CGRect(x: 20, y: btnWiki.frame.maxY+10, width: 120, height: 26))
        let btnProf = UIButton(frame: CGRect(x: 20, y: btnStat.frame.maxY+10, width: 120, height: 26))
        let btnSett = UIButton(frame: CGRect(x: 20, y: btnProf.frame.maxY+10, width: 120, height: 26))
        
        btnRep.setTitle("...REPORTES", forState: UIControlState.Normal)
        btnWiki.setTitle("WIKI", forState: UIControlState.Normal)
        btnStat.setTitle("ESTADÍSTICAS", forState: UIControlState.Normal)
        btnProf.setTitle("PERFIL", forState: UIControlState.Normal)
        btnSett.setTitle("CONFIGURACIÓN", forState: UIControlState.Normal)
        
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
        
        btnRep.tag  = 0;
        btnWiki.tag = 1;
        btnStat.tag = 2;
        btnProf.tag = 3;
        btnSett.tag = 4;
        
        self.addSubview(btnRep)
        self.addSubview(btnWiki)
        self.addSubview(btnStat)
        self.addSubview(btnProf)
        self.addSubview(btnSett)
        
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
    
}
