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
    var grad2:Gradient!
    
    var btnBack:UIButton!
    var btnInfo:UIButton!
    var lblTitle:UILabel!
    var lblSubTit:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgWork = UIImageView(frame: CGRect(x: 0, y: 0, width: 320, height: 194))
        imgWork.image = UIImage(named: "bg1")
        self.view.addSubview(imgWork)
        
        grad2 = Gradient(frame: CGRect(x: 0, y: -50, width: 320, height: 254), type: "Bottom")
        self.view.insertSubview(grad2, aboveSubview: imgWork)
        
        scroll = UIScrollView(frame: self.view.frame)
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
        
        tabBar = UIView(frame: CGRect(x: 0, y: banner.frame.maxY, width: 320, height: 194))
        tabBar.backgroundColor = UIColor(red:0.898, green:0.898, blue:0.898, alpha: 1)
        self.scroll.addSubview(tabBar)
        
        var grad3 = Gradient(frame: CGRect(x: 0, y: self.tabBar.frame.height - 10, width: 320, height: 10), type: "Bottom")
        grad3.alpha = 0.2
        tabBar.addSubview(grad3)
        
        wikiBar = UIView(frame: CGRect(x: 0, y: tabBar.frame.maxY, width: 320, height: 67))
        wikiBar.backgroundColor = UIColor.whiteColor()
        self.scroll.addSubview(wikiBar)
        
        comment = UIButton(frame: CGRect(x: 0, y: wikiBar.frame.maxY, width: 320, height: 49))
        comment.backgroundColor = UIColor(red:0.180, green:0.180, blue:0.180, alpha: 1)
        comment.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        comment.setTitle("199 Comentarios", forState: UIControlState.Normal)
        comment.titleLabel?.font = UIFont(name: "Roboto-Light", size: 13)
        comment.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        comment.setImage(UIImage(named: "comment"), forState: UIControlState.Normal)
        comment.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        comment.contentEdgeInsets = UIEdgeInsetsMake(0, 26, 0, 0)
        self.scroll.addSubview(comment)
        
        scroll.contentSize = CGSize(width: 320, height: comment.frame.maxY)
        
        btnBack = UIButton(frame: CGRect(x: 0, y: 10, width: 56, height: 56))
        btnBack.setImage(UIImage(named: "btnBack"), forState: UIControlState.Normal)
        btnBack.addTarget(self, action: Selector("goBack"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btnBack)

        btnInfo = UIButton(frame: CGRect(x: self.view.frame.maxX - 56, y: 10, width: 56, height: 56))
        btnInfo.setImage(UIImage(named: "btnInfo"), forState: UIControlState.Normal)
        self.view.addSubview(btnInfo)
        
        lblTitle = UILabel(frame: CGRect(x: 10, y: btnInfo.frame.maxY + 10, width: 300, height: 18))
        lblTitle.font = UIFont(name: "Roboto-Regular", size: 17)
        lblTitle.text = "Puente Calle 33 con Av. López ..."
        lblTitle.textAlignment = NSTextAlignment.Center
        lblTitle.textColor = UIColor.whiteColor()
        self.scroll.addSubview(lblTitle)
        
        lblSubTit = UILabel(frame: CGRect(x: 10, y: lblTitle.frame.maxY+5, width: 300, height: 13))
        lblSubTit.font = UIFont(name: "Roboto-Medium", size: 12.5)
        lblSubTit.text = "CATEGORÍA > SUBCATEGORÍA"
        lblSubTit.textAlignment = NSTextAlignment.Center
        lblSubTit.textColor = UIColor(red:0.929, green:0.361, blue:0.180, alpha: 1)
        self.scroll.addSubview(lblSubTit)
    }
    
    func goBack(){
        self.navigationController?.popViewControllerAnimated(true)
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
            btnBack.alpha = 1 - 10*((scrollView.contentOffset.y)/self.view.bounds.size.height)
            btnInfo.alpha = 1 - 10*((scrollView.contentOffset.y)/self.view.bounds.size.height)
        }
        
        if scrollView.contentOffset.y<0{
            imgWork.transform = CGAffineTransformMakeScale(1 - 6*((scrollView.contentOffset.y)/self.view.bounds.size.height), 1-6*((scrollView.contentOffset.y)/self.view.bounds.size.height))
            grad2.transform = CGAffineTransformMakeScale(1 - 6*((scrollView.contentOffset.y)/self.view.bounds.size.height), 1-6*((scrollView.contentOffset.y)/self.view.bounds.size.height))
        }
    }
    
}
