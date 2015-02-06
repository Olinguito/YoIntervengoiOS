//
//  Pictures.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/4/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class Pictures: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(index:Int) {
        super.init()
        self.frame = CGRect(x: 0, y: 0, width: 320, height: 300)
        backgroundColor = UIColor.whiteColor()
        //mas_makeConstraints(<#block: ((MASConstraintMaker!) -> Void)!##(MASConstraintMaker!) -> Void#>)
        
        var view = UIView()
        view.backgroundColor = UIColor.redColor()
        addSubview(view)
        
        var superview = self
        var padding = 10
        
        view.mas_makeConstraints { make in
//            make.top.greaterThanOrEqualTo()
            make.left.equalTo()superview.mas_left
            make.edges.equalTo()(self.mas_top).with().offset()(15)
            make.edges.equalTo()(self.mas_left).with().offset()(15)
            return ()
        }
        
        /*
        
        make.left.equalTo()(self.view.mas_left).with().offset()(15)
        make.right.equalTo()(self.view.mas_right).with().offset()(-15)
        make.top.equalTo()(self.view.mas_top).with().offset()(15)
        make.height.equalTo()(productView.mas_width)
        
        
        UIView *superview = self;
        int padding = 10;
        
                make.top.greaterThanOrEqualTo(superview.top).offset(padding);
        make.left.equalTo(superview.left).offset(padding);
        make.bottom.equalTo(view3.top).offset(-padding);
        make.right.equalTo(view2.left).offset(-padding);
        make.width.equalTo(view2.width);
        
        make.height.equalTo(view2.height);
        make.height.equalTo(view3.height);
        
        
        */
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
