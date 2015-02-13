//
//  DetailReportVC.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/29/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class DetailReportVC: UIViewController,UIScrollViewDelegate,JOTabBarDelegate,UIGestureRecognizerDelegate {
    var scroll:UIScrollView!
    var imgWork:UIImageView!
    var banner:UIView!
    var map:RMStaticMapView!
    var grad2:Gradient!
    var center:CLLocationCoordinate2D!
    var btnBack:UIButton!
    var btnInfo:UIButton!
    var lblTitle:UILabel!
    var lblSubTit:UILabel!
    var buttonHelper:UIButton!
    var lblAdds:UILabel!
    var lblCoun:UILabel!

    
    var story:UIStoryboard!
    
    var report:ReportVC!
    
    var pop1:POPSpringAnimation!
    var pop2:POPSpringAnimation!
    
    
    var tab:JOTabBar!
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer.delegate = self
        
        story = UIStoryboard(name: "Main", bundle: nil)
        
        ////report = self.storyboard?.instantiateViewControllerWithIdentifier("")
        
        
        report = story.instantiateViewControllerWithIdentifier("denunciaView") as ReportVC
        
        
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
        
        var fram:CGRect = CGRect(x: 0, y: 42, width: 120, height: 93)
        map = RMStaticMapView(frame: fram, mapID: "examples.map-z2effxa8", centerCoordinate: CLLocationCoordinate2DMake(4.6015,-74.0698), zoomLevel: 15, completionHandler: nil)
        map.centerCoordinate = CLLocationCoordinate2DMake(4.6015,-74.0698)
        banner.addSubview(map)
        
        var pin = UIImageView(image: UIImage(named: "subPin"))
        pin.center = map.center
        banner.addSubview(pin)
        
        
        lblAdds = UILabel(frame: CGRect(x: map.frame.maxX, y: map.center.y-20, width: self.view.frame.width - 120, height: 13))
        lblAdds.textColor = UIColor.whiteColor()
        lblAdds.textAlignment = NSTextAlignment.Center
        lblAdds.font = UIFont(name: "Roboto-Light", size: 13)
        lblAdds.text = "Calle 57 # 12- 84" 
        banner.addSubview(lblAdds)
        
        lblCoun = UILabel(frame: CGRect(x: map.frame.maxX, y: map.center.y, width: self.view.frame.width - 120, height: 13))
        lblCoun.textColor = UIColor.whiteColor()
        lblCoun.textAlignment = NSTextAlignment.Center
        lblCoun.font = UIFont(name: "Roboto-Light", size: 13)
        lblCoun.text = "Bogotá - Colombia"
        banner.addSubview(lblCoun)
        
        
        pop1 = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        pop1.fromValue = NSValue(CGPoint: CGPoint(x: self.view.frame.width - 35, y: self.view.frame.height - 35))
        pop1.toValue = NSValue(CGPoint: CGPoint(x: self.view.frame.width - 35, y: self.view.frame.height + 35))
        
        pop2 = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        pop2.fromValue = NSValue(CGPoint: CGPoint(x: self.view.frame.width - 35, y: self.view.frame.height + 35))
        pop2.toValue = NSValue(CGPoint: CGPoint(x: self.view.frame.width - 35, y: self.view.frame.height - 35))
        
        let grad1 = Gradient(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64), type: "Top")
        self.view.addSubview(grad1)
    
        var a:NSMutableArray = NSMutableArray()
        
        var info = Info(index: 2)
        var histo = History(index: 2)
        var pictures = Pictures(index: 2)
        var links = Links(index: 2)
        
        a.addObject(["Info", info])
        a.addObject(["Historial", histo])
        a.addObject(["Fotos",pictures])
        a.addObject(["Enlaces",links])
        
        
        tab = JOTabBar(frame: CGRect(x: 0, y: banner.frame.maxY, width: 320, height: 800), data: a)
        tab.delegate = self
        self.scroll.addSubview(tab)
        
        scroll.contentSize = CGSize(width: 320, height: self.view.frame.height+1)
        
        btnBack = UIButton(frame: CGRect(x: 0, y: 10, width: 56, height: 56))
        btnBack.setImage(UIImage(named: "btnBack"), forState: UIControlState.Normal)
        btnBack.addTarget(self, action: Selector("goBack"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btnBack)

        btnInfo = UIButton(frame: CGRect(x: self.view.frame.maxX - 56, y: 10, width: 56, height: 56))
        btnInfo.setImage(UIImage(named: "btnInfo"), forState: UIControlState.Normal)
        btnInfo.addTarget(self, action: Selector("goReport:"), forControlEvents: UIControlEvents.TouchUpInside)
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
        
        buttonHelper = UIButton()
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer!) -> Bool {
        return true
    }
    
    func goReport(sender:UIButton!){
        print("Hola")
        
        print("Hola")
        self.showViewController(report, sender: self)
    }
    
    
    func tappedButton(){
        if (buttonHelper?.isDescendantOfView(self.view) != nil){
            buttonHelper.removeTarget(self, action: Selector("openView:"), forControlEvents: UIControlEvents.TouchUpInside)
            buttonHelper.removeFromSuperview()
        }
        //buttonHelper.removeFromSuperview()
        if tab.getActHelper().tag > 0{
            buttonHelper = tab.getActHelper()
            buttonHelper.frame = CGRect(x: self.view.frame.maxX-70, y: self.view.frame.maxY-70, width: 70, height: 70)
            buttonHelper.addTarget(self, action: Selector("openView:" ), forControlEvents: UIControlEvents.TouchUpInside)
            buttonHelper.setImage(UIImage(named: "linkHelper"), forState: UIControlState.Normal)
            self.view.addSubview(buttonHelper)
        }
        scroll.contentSize = CGSize(width: 320, height: tab.frame.maxY - 200)
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
        
        var translation:CGPoint = scrollView.panGestureRecognizer.translationInView(scrollView.superview!)
        
        if(translation.y > 0)
        {
            if buttonHelper.center.y != (self.view.frame.height - 35){
                buttonHelper.pop_addAnimation(pop2, forKey: "DOWN")
            }
        } else
        {
            if buttonHelper.center.y != (self.view.frame.height + 35){
                buttonHelper.pop_addAnimation(pop1, forKey: "UP")
            }
        }
    }
    
    func openView(sender:UIButton){
        switch(sender.tag){
            case 1: var r = CreateReport(frame: self.view.frame, bttnClose: buttonHelper)
                    self.view.addSubview(r)
            case 2: var r = CreateReport(frame: self.view.frame, bttnClose: buttonHelper)
                    self.view.addSubview(r)
            default: print("")
        }
    }
}