    //
//  DetailReportVC.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/29/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class DetailReportVC: GenericViewController,UIScrollViewDelegate,JOTabBarDelegate,UIGestureRecognizerDelegate,JSImagePickerViewControllerDelegate {
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
    
    var colorView:UIColor!
    
    var pop1:POPSpringAnimation!
    var pop2:POPSpringAnimation!
    var tab:JOTabBar!
    
    var data:NSDictionary!
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        APIManagerClass.getReportWithID(data["id"] as! String)
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.navigationController?.interactivePopGestureRecognizer.delegate = self
        story = UIStoryboard(name: "Main", bundle: nil)
        report = story.instantiateViewControllerWithIdentifier("denunciaView") as! ReportVC
        
        imgWork = UIImageView(frame: CGRect(x: 0, y: 0, width: vW, height: 194))
        
        imgWork.image = UIImage(data: NSData(contentsOfURL: NSURL(string: data["thumb"] as! String)!)!)
        imgWork.layer.masksToBounds = true
        self.view.addSubview(imgWork)
        
        grad2 = Gradient(frame: CGRect(x: 0, y: -50, width: vW, height: 254), type: "Bottom")
        self.view.insertSubview(grad2, aboveSubview: imgWork)
        
        scroll = UIScrollView(frame: self.view.frame)
        scroll.delegate = self
        scroll.backgroundColor = UIColor.clearColor()
        scroll.maximumZoomScale = 10
        scroll.multipleTouchEnabled = false
        self.view.addSubview(scroll)
        
        colorView = (data["type"] as! Int) == 1 ? UIColor.orangeYI() : UIColor.blurYI()
        
        banner = UIView(frame: CGRect(x: 0, y: 125, width: vW, height: 135))
        banner.backgroundColor = UIColor(red:0.180, green:0.180, blue:0.180, alpha: 1)
        self.scroll.addSubview(banner)
        var mask = UIImage(named: "mask")
        var maskLayer = CALayer()
        maskLayer.frame = banner.bounds
        maskLayer.contents = UIImage(named: "mask")?.CGImage
        banner.layer.mask = maskLayer
        
        var fram:CGRect = CGRect(x: 0, y: 42, width: 120, height: 93)
        map = RMStaticMapView(frame: fram, mapID: "robjalkh.a4368786", centerCoordinate: CLLocationCoordinate2DMake(4.6015,-74.0698), zoomLevel: 15, completionHandler: nil)
        //map.centerCoordinate = CLLocationCoordinate2DMake(4.6015,-74.0698)
        banner.addSubview(map)
        
        var pin = UIImageView(image: UIImage(named: (data["type"] as! Int) == 1 ? "subPin" : "subPin2"))
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
        
        let grad1 = Gradient(frame: CGRect(x: 0, y: 0, width: vW, height: 64), type: "Top")
        self.view.addSubview(grad1)
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func goReport(sender:UIButton!){

        self.showViewController(report, sender: self)
    }
    
    
    func tappedButton(){
        if (buttonHelper?.isDescendantOfView(self.view) != nil){
            buttonHelper.removeTarget(self, action: Selector("openView:"), forControlEvents: UIControlEvents.TouchUpInside)
                buttonHelper.setImage(UIImage(named: "btnNewPicture"), forState: UIControlState.Normal)
            buttonHelper.removeFromSuperview()
        }
        //buttonHelper.removeFromSuperview()
        if tab.getActHelper().tag > 0{
            buttonHelper = tab.getActHelper()
            buttonHelper.frame = CGRect(x: self.view.frame.maxX-70, y: self.view.frame.maxY-70, width: 70, height: 70)
            switch(tab.getActHelper().tag){
                case 2: buttonHelper.addTarget(self, action: Selector("openView:" ), forControlEvents: UIControlEvents.TouchUpInside)
                        buttonHelper.setImage(UIImage(named: "linkHelper"), forState: UIControlState.Normal)
                case 1: buttonHelper.addTarget(self, action: Selector("openView:" ), forControlEvents: UIControlEvents.TouchUpInside)
                        buttonHelper.setImage(UIImage(named: "btnNewPicture"), forState: UIControlState.Normal)
            default: print("")
            }
            
            self.view.addSubview(buttonHelper)
        }
        scroll.contentSize = CGSize(width: vW, height: tab.frame.maxY - 200)
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
            
        case 1: var imagePicker = JSImagePickerViewController()
                imagePicker.delegate = self
                imagePicker.showImagePickerInController(self, animated: true)
            case 2: var r = CreateReport(frame: self.view.frame, bttnClose: buttonHelper)
                    self.view.addSubview(r)
            default: print("")
        }
    }
    
    func openCamera(sender:UIButton!){
        /*var imagePicker = JSImagePickerViewController()
        imagePicker.delegate = self
        imagePicker.showImagePickerInController(self.parentViewController(), animated: true)*/
    }
    
    func imagePickerDidSelectImage(image: UIImage!) {
        /*imgReport.image = image
        btnContinue.userInteractionEnabled = true
        if type == 1 {
            btnContinue.setTitle("Crear Reporte", forState: UIControlState.Normal)
            btnContinue.backgroundColor = UIColor.orangeYI()
        }else{
            btnContinue.setTitle("Crear Solicitud", forState: UIControlState.Normal)
            btnContinue.backgroundColor = UIColor.blurYI()
        }
        btnContinue.layer.borderColor = UIColor.clearColor().CGColor*/
    }
    

    func returnObt(responseObject: AnyObject, url: String) {
        //print(responseObject)
        var dataDetail = JSON(responseObject)
        var a:NSMutableArray = NSMutableArray()
        
        var info = Info(index: 2, data: data, color: colorView, frame: self.view.frame)
        var histo = History(index: 2, frame:self.view.frame, data: dataDetail)
        var pictures = Pictures(index: 2, frame: self.view.frame, ini: banner.frame.maxY, data: dataDetail)
        //var links = Links(index: 2, frame:self.view.frame, data:dataDetail[""])
        var links = Links(index: 2, frame: self.view.frame, data: dataDetail)
        
        a.addObject(["Info", info])
        a.addObject(["Historial", histo])
        a.addObject(["Fotos",pictures])
        a.addObject(["Enlaces",links])
        
        tab = JOTabBar(frame: CGRect(x: 0, y: banner.frame.maxY, width: self.view.frame.width, height: self.view.frame.height), data: a, color: colorView)
        tab.delegate = self
        self.scroll.addSubview(tab)
        
        scroll.contentSize = CGSize(width: vW, height: self.view.frame.height+1)
        
        btnBack = UIButton(frame: CGRect(x: 0, y: 10, width: 56, height: 56))
        btnBack.setImage(UIImage(named: "btnBack"), forState: UIControlState.Normal)
        btnBack.addTarget(self, action: Selector("goBack"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btnBack)
        
        btnInfo = UIButton(frame: CGRect(x: self.view.frame.maxX - 56, y: 10, width: 56, height: 56))
        btnInfo.setImage(UIImage(named: "btnInfo"), forState: UIControlState.Normal)
        btnInfo.addTarget(self, action: Selector("goReport:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btnInfo)
        
        lblTitle = UILabel(frame: CGRect(x: 0, y: btnInfo.frame.maxY + 10, width: vW, height: 18))
        lblTitle.font = UIFont(name: "Roboto-Regular", size: 17)
        lblTitle.text = (data["title"] as! String)
        lblTitle.textAlignment = NSTextAlignment.Center
        lblTitle.textColor = UIColor.whiteColor()
        self.scroll.addSubview(lblTitle)
        
        lblSubTit = UILabel(frame: CGRect(x: 0, y: lblTitle.frame.maxY+5, width: vW, height: 13))
        lblSubTit.font = UIFont(name: "Roboto-Medium", size: 12.5)
        lblSubTit.text = "CATEGORÍA > " + (data["subcategory"] as! String).uppercaseString
        lblSubTit.textAlignment = NSTextAlignment.Center
        lblSubTit.textColor = colorView
        self.scroll.addSubview(lblSubTit)
        
        buttonHelper = UIButton()
    }
    
}