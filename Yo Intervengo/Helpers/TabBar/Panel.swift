//
//  Panel.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/7/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class Panel: UIView {
    var share:UIButton!
    var report:UIButton!
    var like:UIButton!
    var dislike:UIButton!
    
    convenience init() {
        self.init()
        self.frame = CGRect(x: 0, y: 0, width: 291, height: 24)
        self.layer.borderColor = UIColor.greyLight().CGColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5
        
        let w = self.frame.width/4
        let h:CGFloat = 24
        
        share   = UIButton(frame: CGRect(x: 0, y: 0, width: w, height: h))
        report  = UIButton(frame: CGRect(x: 1*w, y: 0, width: w, height: h))
        like    = UIButton(frame: CGRect(x: 2*w, y: 0, width: w, height: h))
        dislike = UIButton(frame: CGRect(x: 3*w, y: 0, width: w, height: h))
        
        share.setTitle("Compartir", forState: UIControlState.Normal)
        report.setTitle("Denunciar", forState: UIControlState.Normal)
        like.setTitle("100", forState: UIControlState.Normal)
        dislike.setTitle("50", forState: UIControlState.Normal)
        
        
        like.setImage(UIImage(named: "like_panel"), forState: UIControlState.Normal)
        dislike.setImage(UIImage(named: "dislike_panel"), forState: UIControlState.Normal)
        
        var title:String = like.titleLabel?.text ?? "3333"
        var vw:CGFloat = CGFloat(count(title))*10
        
        print(vw)
        like.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        like.titleEdgeInsets = UIEdgeInsetsMake(0.0, -11, 0.0, 0.0)
        like.imageEdgeInsets = UIEdgeInsetsMake(0.0, 15 + vw, 0.0, 0.0)
        
        title = dislike.titleLabel?.text ?? "333"
        vw = CGFloat(count(title))*10
                print(vw)
        dislike.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        dislike.titleEdgeInsets = UIEdgeInsetsMake(0.0, -11, 0.0, 0.0)
        dislike.imageEdgeInsets = UIEdgeInsetsMake(0.0, 15 + vw, 0.0, 0.0)

        configure(share)
        configure(report)
        configure(like)
        configure(dislike)
        
        for(var i:CGFloat=1;i<=3;i++){
            var line = UIBezierPath(rect: CGRect(x: i*w, y: 3, width: 0, height: 18))
            var staticLine = CAShapeLayer()
            staticLine.path = line.CGPath
            staticLine.strokeColor = UIColor.greyLight().CGColor
            self.layer.addSublayer(staticLine)
        }
    }
    
    func configure(button:UIButton!){
        button.setTitleColor(UIColor.greyLight(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Light", size: 10)
        addSubview(button)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
