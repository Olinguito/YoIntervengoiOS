//
//  LinkComponent.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/7/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class LinkComponent: UIView {
    var title:UIButton!
    var subtitle:UILabel!
    var date:UILabel!
    var actionPanel:Panel!
    let paddinLeft:CGFloat = 14
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init() {
        super.init()
        
        self.frame = CGRect(x: 0, y: 0, width: 320, height: 106)
        
        title = UIButton(frame: CGRect(x: paddinLeft, y: 14, width: frame.width, height: 16))
        title.setTitle("Nota publicada en elespectador.com", forState: UIControlState.Normal)
        title.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        title.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        title.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        addSubview(title)
        
        subtitle = UILabel(frame: CGRect(x: paddinLeft, y: title.frame.maxY + 2, width: frame.width, height: 13))
        subtitle.text = "Descripción del doc o artículo"
        subtitle.font = UIFont(name: "Roboto-Italic", size: 12)
        subtitle.textColor = UIColor.orangeYI()
        addSubview(subtitle)
        
        date = UILabel(frame: CGRect(x: paddinLeft, y: subtitle.frame.maxY + 2, width: frame.width, height: 11))
        date.text = "Fecha de publicación: Enero 26 de 2014"
        date.font = UIFont(name: "Roboto-Light", size: 10)
        date.textColor = UIColor.greyDark()
        addSubview(date)
        
        actionPanel = Panel()
        actionPanel.center = CGPoint(x: frame.width/2, y: date.frame.maxY + 20)
        addSubview(actionPanel)
        
        
        var line = UIBezierPath(rect: CGRect(x: 0, y: frame.maxY-1, width: frame.width, height: 0))
        var shape = CAShapeLayer(layer: line)
        var staticLine = CAShapeLayer()
        staticLine.path = line.CGPath
        staticLine.strokeColor = UIColor.greyLight().CGColor
        self.layer.addSublayer(staticLine)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
