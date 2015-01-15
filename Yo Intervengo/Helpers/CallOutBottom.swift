//
//  CallOutBottom.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/13/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import Foundation
import UIKit


class CallOutBottom: UIView{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red:0.898, green:0.898, blue:0.898, alpha: 1)
        let stat = UIImageView(frame: CGRect(x: 21, y: 15, width: 11, height: 11))
        stat.image = UIImage(named: "stat")
        self.addSubview(stat)
        
        let title = UILabel(frame: CGRect(x: 41, y: 13, width: 112, height: 15))
        title.font = UIFont(name: "Roboto-Light", size: 14)
        title.text = "Terminada"
        self.addSubview(title)
        
        
        let div = UIImageView(frame: CGRect(x: frame.width/2, y: 8, width: 1, height: 26))
        div.image = UIImage(named: "div")
        self.addSubview(div)
        
        
        let inter = UIImageView(frame: CGRect(x: 160, y: 10, width: 11, height: 21))
        inter.image = UIImage(named: "inter")
        self.addSubview(inter)
        
        
        let btn = UILabel(frame: CGRect(x: 180, y: 8, width: 70, height: 14))
        btn.font = UIFont(name: "Roboto-Light", size: 14)
        btn.textColor = UIColor(red:0.404, green:0.404, blue:0.404, alpha: 1)
        btn.text = "Respaldar"
        self.addSubview(btn)
        
        let btnl2 = UILabel(frame: CGRect(x: 180, y: 25, width: 80, height: 10))
        btnl2.font = UIFont(name: "Roboto-Light", size: 9)
        btnl2.textColor = UIColor(red:0.404, green:0.404, blue:0.404, alpha: 1)
        btnl2.text = "199 mil respaldos"
        self.addSubview(btnl2)
        
        let support = UIButton(frame: CGRect(x: frame.width/2, y: 0, width: frame.width/2, height: frame.height))
        support.addTarget(self, action: "support", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(support)
    }
    func support(){
        println("Supportando")
    }
}
