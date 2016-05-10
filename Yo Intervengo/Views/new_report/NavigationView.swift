//
//  NavigationView.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/9/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import UIKit
import pop

@objc protocol NavigationViewDelegate{
    optional func closeNavigationReport()
    optional func cleanType()
    optional func cleanCategory()
}

public class NavigationView: UIView {
    
    internal var type:Type?        { didSet{reloadType()}}
    internal var subtype:Category? { didSet{reloadSubtype()}}
    
    private var btnClose:UIButton!
    private var btnType:UIButton!
    private var btnSubtype:UIButton!
    private var lblInformation:UILabel!
    
    internal var delegate:NavigationViewDelegate?
    
    private var constraintType:NSLayoutConstraint!
    private var constraintSubType:NSLayoutConstraint!
    private var constraintLabel:NSLayoutConstraint!
    
    init(){
        super.init(frame: CGRectZero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        lblInformation = UILabel()
        lblInformation.textAlignment = .Right
        lblInformation.numberOfLines = 2
        lblInformation.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lblInformation)
        
        btnSubtype = UIButton()
        btnSubtype.translatesAutoresizingMaskIntoConstraints = false
        btnSubtype.addTarget(self, action: #selector(self.cleanFromSubtype), forControlEvents: .TouchUpInside)
        self.addSubview(btnSubtype)
        
        btnType = UIButton()
        btnType.addTarget(self, action: #selector(self.cleanFromType), forControlEvents: .TouchUpInside)
        btnType.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(btnType)
        
        btnClose                 = UIButton()
        btnClose.setImage(UIImage(named: "mas"), forState: .Normal)
        btnClose.translatesAutoresizingMaskIntoConstraints = false
        btnClose.addTarget(self, action: #selector(self.closeNavigation), forControlEvents: .TouchUpInside)
        self.addSubview(btnClose)
        
        
        let option = NSLayoutFormatOptions(rawValue: 0)
        let sizes  = ["lg":70,"s":50,"ss":38]
        let views  = ["c":btnClose,"t":btnType,"st":btnSubtype,"l":lblInformation]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[c(s)]", options: option, metrics: sizes, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[t(lg)]", options: option, metrics: sizes, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[st(ss)]", options: option, metrics: sizes, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[l(s)]", options: option, metrics: sizes, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[c(s)]-8-|", options: option, metrics: sizes, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[t(lg)]", options: option, metrics: sizes, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[st(ss)]", options: option, metrics: sizes, views: views))
        
        
        self.addConstraint(NSLayoutConstraint(item: self.btnClose, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.btnType, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.btnSubtype, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.lblInformation, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        
        
        constraintType = NSLayoutConstraint(item: self.btnClose, attribute: .CenterX, relatedBy: .Equal, toItem: self.btnType, attribute: .CenterX, multiplier: 1, constant: 0)
        self.addConstraint(constraintType)
        
        constraintLabel = NSLayoutConstraint(item: self.lblInformation, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0)
        self.addConstraint(constraintLabel)
        
        constraintSubType = NSLayoutConstraint(item: self.btnSubtype, attribute: .CenterX, relatedBy: .Equal, toItem: self.btnType, attribute: .CenterX, multiplier: 1, constant: 0)
        self.addConstraint(constraintSubType)
    }
    
    
    func openNavigation(){
        let an = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        an.toValue = -0.75
        an.springBounciness = 10
        btnClose.layer.pop_addAnimation(an, forKey: "Rotate")
    }
    
    public override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, withEvent: event)
        if hitView == self {
            return nil
        }else{
            return hitView
        }
    }
    
    func closeNavigation(){
        let an = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        an.toValue = 0
        an.springBounciness = 10
        btnClose.layer.pop_addAnimation(an, forKey: "Rotate")
        delegate?.closeNavigationReport!()
    }
    
    func reloadType(){
        let an         = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        let lbl        = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        let alphaType  = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
        let alphaLabel = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
        if let _type = self.type{
            self.btnType.setBackgroundImage(UIImage(named: (_type.icon)!), forState: .Normal)
            self.lblInformation.text = _type.name?.uppercaseString
            an.toValue               = 60
            lbl.toValue              = -130
            alphaType.toValue        = 1
            alphaLabel.toValue       = 1
            self.subtype             = nil
        }else{
            an.toValue               = 0
            lbl.toValue              = 0
            alphaType.toValue        = 0
            alphaLabel.toValue       = 0
        }
        an.springBounciness = 10
        constraintType.pop_addAnimation(an, forKey: "centerType")
        constraintLabel.pop_addAnimation(lbl, forKey: "labelType")
        lblInformation.pop_addAnimation(alphaLabel, forKey: "alphaLabel")
        btnType.pop_addAnimation(alphaType, forKey: "alphaType")
    }
    
    func reloadSubtype(){
        let an         = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        let lbl        = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        let alphaType  = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
        if let _subtype = self.subtype{
            let icon = "btn_"+(_subtype.type?.slug)!+"_"+_subtype.slug!
            self.btnSubtype.setBackgroundImage(UIImage(named: icon), forState: .Normal)
            self.lblInformation.text = _subtype.name?.uppercaseString
            an.toValue               = -55
            lbl.toValue              = -180
            alphaType.toValue        = 1
        }else{
            self.lblInformation.text = type?.name?.uppercaseString
            an.toValue               = 0
            lbl.toValue              = -130
            alphaType.toValue        = 0
        }
        an.springBounciness = 10
        constraintSubType.pop_addAnimation(an, forKey: "centerSubtype")
        constraintLabel.pop_addAnimation(lbl, forKey: "labelSubtype")
        btnSubtype.pop_addAnimation(alphaType, forKey: "alphaSubtype")
    }
    
    func cleanFromType(){
        self.subtype = nil
        self.type    = nil
        delegate?.cleanType!()
    }
    
    func cleanFromSubtype(){
        self.subtype = nil
        delegate?.cleanCategory!()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
