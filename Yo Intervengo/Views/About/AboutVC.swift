//
//  AboutVC.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 4/29/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class AboutVC: GenericViewController {
    var scroll:UIScrollView!
    var textDesc:UITextView!
    var thksLbl:UILabel!
    var sponsors:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        scroll = UIScrollView(frame: CGRectMake(0, 80, vW, vH - 80))
        scroll.backgroundColor = UIColor.clearColor()
        scroll.maximumZoomScale = 10
        scroll.multipleTouchEnabled = false
        self.view.addSubview(scroll)
        
        var lblInfo = UILabel()
        var text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
        lblInfo.text = text
        lblInfo.textColor = UIColor.greyDark()
        lblInfo.font = UIFont(name: "RobotoSlab-Light", size: 15)
        lblInfo.numberOfLines = 0
        lblInfo.textAlignment = NSTextAlignment.Justified
        lblInfo.frame = CGRect(x: 30, y: 0, width: vW - 60, height: heightForView(text, font: lblInfo.font!, width: vW - 60))
        scroll.addSubview(lblInfo)
        
        thksLbl = UILabel(frame: CGRectMake(0, lblInfo.frame.maxY + 20, vW, 16))
        thksLbl.textAlignment = NSTextAlignment.Center
        thksLbl.text = "Gracias al apoyo de"
        thksLbl.font = UIFont(name: "RobotoSlab-Light", size: 15)
        scroll.addSubview(thksLbl)
        sponsors = UIImageView(image: UIImage(named: "sponsor"))
        sponsors.center = CGPointMake(self.view.center.x, thksLbl.frame.maxY + 20 + sponsors.frame.midY)
        scroll.addSubview(sponsors)
        scroll.contentSize = CGSize(width: vW, height: sponsors.frame.maxY + 20)
    }

    override func viewWillAppear(animated: Bool) {
        self.showNavBar(true)
        actView = 1
        self.menuView.setColor(actView+3330)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
