//
//  HorizontalButtonsView.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/15/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import UIKit

protocol HorizontalButtonsViewDelegate{
    func tappedLeftButton(horizontalView:HorizontalButtonsView)
    func tappedRightButton(horizontalView:HorizontalButtonsView)
}

class HorizontalButtonsView: UIStackView {
    private var btnLeft:UIButton!
    private var btnRight:UIButton!
    var delegate: HorizontalButtonsViewDelegate?
    
    init() {
        super.init(frame: CGRectZero)
        
        self.alignment    = .Fill
        self.axis         = .Horizontal
        self.distribution = .FillEqually
        self.spacing      = 10
        
        btnLeft                    = UIButton()
        btnLeft.layer.cornerRadius = 10
        btnLeft.backgroundColor    = UIColor.clearColor()
        btnLeft.setTitle("Volver", forState: .Normal)
        btnLeft.layer.borderColor = UIColor.addThemeContrast().CGColor
        btnLeft.setTitleColor(UIColor.addThemeContrast(), forState: .Normal)
        btnLeft.layer.borderWidth = 2
        btnLeft.addTarget(self, action: #selector(self.leftButtonTapped), forControlEvents: .TouchUpInside)
        self.addArrangedSubview(btnLeft)
        
        btnRight = UIButton()
        btnRight.layer.cornerRadius = 10
        btnRight.backgroundColor    = UIColor.clearColor()
        btnRight.setTitle("Siguiente", forState: .Normal)
        btnRight.layer.borderColor  = UIColor.addThemeContrast().CGColor
        btnRight.setTitleColor(UIColor.addThemeContrast(), forState: .Normal)
        btnRight.layer.borderWidth = 2
        btnRight.addTarget(self, action: #selector(self.leftButtonTapped), forControlEvents: .TouchUpInside)
        self.addArrangedSubview(btnRight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func leftButtonTapped(){
        delegate?.tappedLeftButton(self)
    }
    
    func rightButtonTapped(){
        delegate?.tappedRightButton(self)
    }
}
