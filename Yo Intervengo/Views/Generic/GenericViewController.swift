//
//  GenericViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/16/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class GenericViewController: UIViewController,APIManagerDelegate,LeftMenuDelegate {
    var conn:Connection!
    var APIManagerClass:APIManager!
    var alert:JOAlert!
    var alertInternet:JOAlert!
    var menuView: LeftMenu!
    var actView:Int!
    
    var vH:CGFloat!
    var vW:CGFloat!
    
    //Nav Bar
    var navBar:UIView!
    var lblHeader:UILabel!
    var btnLeft:UIButton!
    var btnRight:UIButton!
    var reachability:Reachability!
    
    var loaded:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vH = self.view.frame.height
        vW = self.view.frame.width
        
        APIManagerClass = APIManager()
        APIManagerClass.delegate = self

        alert = JOAlert(textNFrame: "", self.view.frame, true)
        alertInternet = JOAlert(textNFrame: "No tienes internet!", self.view.frame, false)
        
        menuView = LeftMenu(frame: CGRect(x: -204, y: 0, width: 204, height: vH))
        menuView.delegate = self
        
        navBar = UIView(frame: CGRectMake(0, 0, vW, 64))
        navBar.backgroundColor = UIColor.greyNav()
        self.view.addSubview(navBar)
        
        lblHeader = UILabel(frame: CGRectMake(0, 20, vW, 44))
        lblHeader.text = ""
        lblHeader.textAlignment = NSTextAlignment.Center
        lblHeader.textColor = UIColor.whiteColor()
        lblHeader.font = UIFont(name: "Roboto-Light", size: 18)
        navBar.addSubview(lblHeader)
        
        btnLeft = UIButton(frame: CGRectMake(0, 20, 50, 44))
        btnLeft.setImage(UIImage(named: "btnBack"), forState: UIControlState.Normal)
        btnLeft.addTarget(self, action: Selector("goBack:"), forControlEvents: UIControlEvents.TouchUpInside)
        navBar.addSubview(btnLeft)
        
        showNavBar(false)
        
        reachability = Reachability.reachabilityForInternetConnection()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()
        
        loaded = false
    }
    
    func goRoot(){
        println("Going to root")
        self.viewDidAppear(false)
        self.navigationController?.popToRootViewControllerAnimated(false)
        alertInternet.dismissAlert()
    }
    
    func goBack(sender:UIButton){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as! Reachability
        if reachability.isReachable() {
            println("Reachable")
            if (self.navigationController != nil) {
                var timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("goRoot"), userInfo: nil, repeats: false)
            }else{
                alertInternet.dismissAlert()
                self.viewDidLoad()
            }
        } else {
            println("UnReachable")
            //self.presentViewController(NoNetworkVC(), animated: false, completion: nil)
            if !alertInternet.isDescendantOfView(self.view){
                self.view.addSubview(alertInternet)
            }
            alertInternet.showAlert()
        }
    }
    
    func showNavBar(value:Bool){
        if value{
            navBar.userInteractionEnabled = true
            navBar.alpha = 1
        }else{
            navBar.userInteractionEnabled = false
            navBar.alpha = 0
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func goTo(index: Int) {
        print(String(actView) + "y" + String(index))
        if actView != index {
            switch (index){
                case 0:

                        self.navigationController?.popToRootViewControllerAnimated(false)
                case 1: var c  = AboutVC()

                        self.navigationController?.pushViewController(c, animated: false)
                case 2: print(3)
                case 3: print(4)
                default: print(5)
            }
            menuView.interact()
        }
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
