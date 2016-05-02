//
//  Loader.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 6/2/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit
import pop

class Loader: UIView {
    var activityIndicatorView:DGActivityIndicatorView!
    
    init(frame: CGRect, c1:UIColor, c2:UIColor) {
        super.init(frame: frame)
        self.backgroundColor = c1
        self.alpha = 1
        activityIndicatorView = DGActivityIndicatorView(type: DGActivityIndicatorAnimationType.NineDots, tintColor: c2)
        activityIndicatorView.center = self.center
        self.addSubview(activityIndicatorView)
    }
    
    func show(){
        activityIndicatorView.startAnimating()
    }
    
    func dismiss(){
        activityIndicatorView.stopAnimating()
        self.removeFromSuperview()
    }
    
    func dismissAnimate()
    {
        let dismissAnimation = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
        dismissAnimation.toValue = 0
        self.pop_addAnimation(dismissAnimation, forKey: "dismiss")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
