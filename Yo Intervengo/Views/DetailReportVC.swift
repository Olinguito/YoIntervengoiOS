//
//  DetailReportVC.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/29/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class DetailReportVC: UIViewController,UIScrollViewDelegate {
    var scroll:UIScrollView!
    var imgWork:UIImageView!
    var banner:UIView!
    var tabBar:UIView!
    var wikiBar:UIView!
    var comment:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgWork = UIImageView(frame: CGRect(x: 0, y: 0, width: 320, height: 194))
        imgWork.image = UIImage(named: "bg1")
        self.view.addSubview(imgWork)
        
        scroll = UIScrollView(frame: self.view.frame)
        //scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: 320, height: 600))
        scroll.delegate = self
        scroll.backgroundColor = UIColor.clearColor()
        scroll.maximumZoomScale = 10
        scroll.multipleTouchEnabled = false
        self.view.addSubview(scroll)
        
        banner = UIView(frame: CGRect(x: 0, y: 125, width: 320, height: 135))
        banner.backgroundColor = UIColor(red:0.180, green:0.180, blue:0.180, alpha: 1)
        self.scroll.addSubview(banner)
        var mask = UIImage(named: "mask")
        var maskLayer = CALayer()
        maskLayer.frame = banner.bounds
        maskLayer.contents = UIImage(named: "mask")?.CGImage
        banner.layer.mask = maskLayer
        
        tabBar = UIView(frame: CGRect(x: 0, y: banner.frame.maxY, width: 320, height: 204))
        tabBar.backgroundColor = UIColor(red:0.898, green:0.898, blue:0.898, alpha: 1)
        self.scroll.addSubview(tabBar)
        
        wikiBar = UIView(frame: CGRect(x: 0, y: tabBar.frame.maxY, width: 320, height: 67))
        wikiBar.backgroundColor = UIColor.whiteColor()
        self.scroll.addSubview(wikiBar)
        
        comment = UIButton(frame: CGRect(x: 0, y: wikiBar.frame.maxY, width: 320, height: 49))
        comment.backgroundColor = UIColor(red:0.180, green:0.180, blue:0.180, alpha: 1)
        self.scroll.addSubview(comment)
        
        scroll.contentSize = CGSize(width: 320, height: comment.frame.maxY)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y>0{
            imgWork.transform = CGAffineTransformMakeTranslation(0, -scrollView.contentOffset.y/2)
        }
        
        if scrollView.contentOffset.y<0{
            imgWork.transform = CGAffineTransformMakeScale(1 - 6*((scrollView.contentOffset.y)/self.view.bounds.size.height), 1-6*((scrollView.contentOffset.y)/self.view.bounds.size.height))
        }
    }
    
}
