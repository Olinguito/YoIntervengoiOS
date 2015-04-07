//
//  JOaddReport.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/24/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

@objc protocol JOaddReportDelegate{
    func reportCreated(location:CLLocationCoordinate2D, type:Int)
}

class JOaddReport: UIView,LNERadialMenuDataSource,LNERadialMenuDelegate,JOSideBarMenuDelegate,JOCentralMenuDelegate,JSImagePickerViewControllerDelegate,UITextFieldDelegate, UITextViewDelegate{
    // MARK: -VAR DEFFINITION\
    var delegate:JOaddReportDelegate!
    
    var step = 0
    let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
    var btnClose:UIButton!
    var btnCategoty:UIButton!
    var btnSubcategory:UIButton!
    var lblIndicator:UILabel!
    var labels:Int!
    var this:JOSideBarMenu!
    var this2:JOCentralMenu!
    
    var sideData:NSMutableArray!
    var centralData:NSMutableArray!
    var conn:Connection!
    
    var str1:String!
    var str2:String!
    var str3:String!
    
    var catId:Int!
    
    //STEP 4
    var localization:CLLocationCoordinate2D!
    var btnBack:UIButton!
    var btnContinue:UIButton!
    var mapLocation:RMMapView!
    var pinIcon:UIImageView!
    
    
    //STEP 5
    var txtTitle:UITextField!
    var txtDesc:UIView!
    var txtD:UITextView!
    
    
    //STEP 6
    var imgReport:UIImageView!
    var btnAddImage:UIButton!
    
    var type:Int!
    
    var alert:JOAlert!
    
    var APIManagerClass:APIManager!
    var txtTit:String!
    var txtDes:String!
    
    
    // MARK: -INIT
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, bttnClose:UIButton, labels:Int, coodinate:CLLocationCoordinate2D) {
        super.init(frame: frame)
        step = 1
        APIManagerClass = APIManager()
        alert = JOAlert(textNFrame: "", self.frame)
        localization = coodinate
        txtTit = ""
        txtDes = ""
        btnClose = UIButton(frame: bttnClose.frame)
        btnClose.center = bttnClose.center
        self.labels = labels
        btnClose.setImage(bttnClose.backgroundImageForState(UIControlState.Normal), forState: UIControlState.Normal)
        btnClose.addTarget(self, action: Selector("close"), forControlEvents: UIControlEvents.TouchUpInside)
        
        conn = Connection()
        
        var blurView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        blurView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        self.addSubview(blurView)
        self.addSubview(btnClose)
        
        btnBack = UIButton(frame: CGRect(x: frame.midX-152, y: 0, width: 142, height: 45))
        btnBack.layer.borderColor = UIColor(red:0.878, green:0.886, blue:0.894, alpha: 1).CGColor
        btnBack.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        btnBack.layer.borderWidth = 1.0
        btnBack.layer.cornerRadius = 5
        btnBack.alpha = 0
        btnBack.setTitle("Volver", forState: UIControlState.Normal)
        btnBack.addTarget(self, action: Selector("goBack:"), forControlEvents: UIControlEvents.TouchUpInside)
        btnBack.userInteractionEnabled = false
        self.addSubview(btnBack)
        
        btnContinue = UIButton(frame: CGRect(x: frame.midX+10, y: 0, width: 142, height: 45))
        btnContinue.layer.borderColor = UIColor(red:0.878, green:0.886, blue:0.894, alpha: 1).CGColor
        btnContinue.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        btnContinue.layer.borderWidth = 1.0
        btnContinue.layer.cornerRadius = 5
        btnContinue.addTarget(self, action: Selector("goContinue:"), forControlEvents: UIControlEvents.TouchUpInside)
        btnContinue.setTitle("Siguente", forState: UIControlState.Normal)
        btnContinue.alpha = 0
        btnContinue.userInteractionEnabled = false
        self.addSubview(btnContinue)
        
        let source = RMMapboxSource(mapID: "olinguito.c389ab51")
        mapLocation = RMMapView(frame: CGRect(x: 15, y: 40, width: self.frame.width - 30, height: btnBack.frame.minY - 70), andTilesource: source)
        
    }
    
    func setButtons(step:Int){
        if step < 4 {
            btnContinue.alpha = 0
            btnContinue.userInteractionEnabled = false
            btnBack.alpha = 0
            btnBack.userInteractionEnabled = false
        }else{
            btnContinue.alpha = 1
            btnContinue.userInteractionEnabled = true
            btnBack.alpha = 1
            btnBack.userInteractionEnabled = true
        }
    }
    
    func showMenu(step:Int, atPoint point:CGPoint){
        setButtons(step)
        configButton(step)
        switch (step){
        case 1:
            var an = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
            an.toValue = -0.75
            an.springBounciness = 10
            btnClose.layer.pop_addAnimation(an, forKey: "Rotate")
            var thisMenu = LNERadialMenu(fromPoint: point, withDataSource: self, andDelegate: self,withFrame: self.frame, andLabels:Boolean(labels))
                thisMenu.radialMenuIdentifier = "show"
                self.insertSubview(thisMenu, belowSubview: btnClose)
                thisMenu.showMenu()
        case 2:
                sideData = conn.getCategories(lblIndicator.text == "REPORTE")
                this = JOSideBarMenu(frame: CGRectMake(0, 0, 320, min(370, self.frame.height - (100 + btnClose.frame.height)))  , data: sideData)
                this.frame.origin = CGPoint(x: 0, y: (frame.height - btnClose.frame.height)-this.frame.height)
                this.delegate = self
                self.addSubview(this)
        case 3:
                var d = NSMutableArray()
                var t = (self.frame.size.height-450)/2
                type = lblIndicator.text == "REPORTE" ? 1 : 0
                centralData = conn.getSubcategories(catId)
                this2 = JOCentralMenu(frame: CGRectMake(0, t, 320, 400) , data: centralData, type: type)
                this2.delegate = self
                self.insertSubview(this2, belowSubview: btnCategoty)
        case 4:
                btnBack.frame.origin.y = btnCategoty.frame.minY - 55
                btnContinue.frame.origin.y = btnCategoty.frame.minY - 55
                mapLocation.frame = CGRect(x: 15, y: 40, width: self.frame.width - 30, height: btnBack.frame.minY - 70)
                mapLocation.setZoom(15, animated: true)
                mapLocation.centerCoordinate = localization
                mapLocation.layer.cornerRadius = 10
                self.addSubview(mapLocation)
                if type == 1{
                    pinIcon = UIImageView(image: UIImage(named: "Pin"))
                }else{
                    pinIcon = UIImageView(image: UIImage(named: "Pin2"))
                }
                pinIcon.center = mapLocation.center
                self.addSubview(pinIcon)
        case 5:
                mapLocation.removeFromSuperview()
                pinIcon.removeFromSuperview()
                txtTitle = UITextField(frame: CGRect(x: -1, y: 115, width: self.frame.width+2, height: 49))
                txtTitle.layer.borderColor = UIColor.whiteColor().CGColor
                txtTitle.layer.borderWidth = 1
                txtTitle.delegate = self
                txtTitle.textAlignment = NSTextAlignment.Center
                txtTitle.textColor = UIColor.whiteColor()
                var placeholder = NSAttributedString(string: "Titulo", attributes: [NSForegroundColorAttributeName : UIColor.lightGrayColor()])
                txtTitle.attributedPlaceholder = placeholder
                txtTitle.tintColor = UIColor.orangeYI()
                txtTitle.keyboardAppearance = UIKeyboardAppearance.Dark
                self.addSubview(txtTitle)
                txtDesc = UIView(frame: CGRect(x: -1, y: txtTitle.frame.maxY, width: self.frame.width+2, height: 120))
                //txtDesc.delegate = self
                txtDesc.layer.borderColor = UIColor.whiteColor().CGColor
                txtDesc.tintColor = UIColor.orangeYI()
                txtDesc.backgroundColor = UIColor.clearColor()
                txtDesc.layer.borderWidth = 1
                var tit = UILabel(frame: CGRect(x: 0, y: 10, width: txtDesc.frame.width, height: 15))
                tit.textColor = UIColor.lightGrayColor()
                tit.text = "Descripción del reporte"
                tit.font = UIFont(name: "Roboto-Light", size: 18)
                tit.textAlignment = NSTextAlignment.Center
                txtDesc.addSubview(tit)
                txtD = UITextView(frame: CGRect(x: 20, y: 38, width: txtDesc.frame.width-40, height: 80))
                txtD.delegate = self
                txtD.textColor = UIColor.whiteColor()
                txtD.backgroundColor = UIColor.clearColor()
                txtD.keyboardAppearance = UIKeyboardAppearance.Dark
                txtD.font = UIFont(name: "Roboto-Light", size: 18)
                txtDesc.addSubview(txtD)
                if txtTit != "" && txtDes != "" {
                    txtTitle.text = txtTit
                    txtD.text = txtDes
                }
                self.addSubview(txtDesc)
        case 6:
            if txtTitle.text == "" || txtD.text == "" {
                self.step--
                alert.setText("Ninguno puede estar vacio!!!")
                self.addSubview(alert)
                alert.showAlert()
            }else{
                txtTit = txtTitle.text
                txtDes = txtD.text
                btnContinue.userInteractionEnabled = false
                txtTitle.removeFromSuperview()
                txtDesc.removeFromSuperview()
                imgReport = UIImageView(frame: CGRect(x: -1, y: (btnBack.frame.minY - 221)/2, width: self.frame.width+2, height: 221))
                imgReport.contentMode = UIViewContentMode.ScaleAspectFill
                imgReport.layer.masksToBounds = true
                imgReport.layer.borderColor = UIColor.whiteColor().CGColor
                imgReport.layer.borderWidth = 1
            
                self.addSubview(imgReport)
                btnAddImage = UIButton(frame: CGRect(x: 0, y: 0, width: 95, height: 94))
                btnAddImage.setImage(UIImage(named: "btnAddPic"), forState: UIControlState.Normal)
                btnAddImage.center = imgReport.center
                btnAddImage.addTarget(self, action: Selector("openCamera:") , forControlEvents: UIControlEvents.TouchUpInside)
                self.addSubview(btnAddImage)
            }
        case 7:
                //Aca se envia al API
                /*
            
                {
                    "description": "",
                    "location": "geopoint",
                    "status": 0,
                    "title": "",
                    "address": "",
                    "type": 0,
                    "category": {
                        "name": "",
                        "icon": "",
                        "parent": "",
                        "id": "objectid"
                    },
                    "link": [
                        {
                            "source": "",
                            "date": "",
                            "description": "",
                            "url": "",
                            "title": "",
                            "type": 0,
                            "id": "objectid"
                        }
                    ],
                        "id": "objectid"
                }
            
                */
                delegate.reportCreated(localization, type: type)
                self.removeFromSuperview()
                var dataRep:NSDictionary = ["description":txtDes, "location":[localization.latitude, localization.longitude], "title":txtTit, "type":type]
                //APIManagerClass.postReport(dataRep)
        default: println("Default")
        }
    }
    
    // MARK: -RADIAL MENU DELEGATE ::STEP 2
    func radialMenu(radialMenu: LNERadialMenu!, didSelectButton button: UIButton!) {
        step = 2
        btnCategoty = UIButton(frame: button.frame)
        btnCategoty.center = btnClose.center
        btnCategoty.setBackgroundImage(button.backgroundImageForState(UIControlState.Normal), forState: UIControlState.Normal)
        btnCategoty.tag = button.tag
        btnCategoty.addTarget(self, action: Selector("goBack:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(btnCategoty)
        var pop = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        pop.toValue = NSValue(CGPoint: CGPoint(x: self.frame.size.width-100, y: btnClose.center.y))
        var wl = button.titleLabel?.text?.utf16Count
        var t = Int(btnCategoty.frame.origin.x) - 265
        lblIndicator = UILabel(frame: CGRect(x: t, y: (Int(btnCategoty.center.y) - 20), width: 200, height: 40))
        str1 = button.titleLabel?.text
        lblIndicator.numberOfLines = 2
        lblIndicator.alpha = 0
        lblIndicator.text = str1
        lblIndicator.textColor = UIColor.whiteColor()
        lblIndicator.textAlignment = NSTextAlignment.Right
        lblIndicator.font = UIFont(name: "Roboto-Regular", size: 15)
        self.addSubview(lblIndicator)
        var pop2 = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        pop2.duration = 2
        pop2.toValue = 1
        lblIndicator.pop_addAnimation(pop2, forKey: "Test2")
        btnCategoty.pop_addAnimation(pop, forKey: "TEST")
        showMenu(2, atPoint: CGPointZero)
        radialMenu.closeMenu()
    }
    
    func radialMenu(radialMenu: LNERadialMenu!, closingMenu close: Boolean) {
        //closeMenu()
    }
    
    func numberOfButtonsForRadialMenu(radialMenu: LNERadialMenu!) -> Int {
        return 2
    }
    
    func radiusLenghtForRadialMenu(radialMenu: LNERadialMenu!) -> CGFloat {
        return 60
    }
    
    func radialMenu(radialMenu: LNERadialMenu!, elementAtIndex index: Int) -> UIButton! {
        var element : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        switch index{
        case 0: element.titleLabel?.text = "REPORTE"
        element.setBackgroundImage(UIImage(named: "repo"), forState: UIControlState.Normal)
        case 1: element.titleLabel?.text = "SOLICITUD"
        element.setBackgroundImage(UIImage(named: "solicitud"), forState: UIControlState.Normal)
        default:element.titleLabel?.text = "SOLICITUD"
        element.setBackgroundImage(UIImage(named: "solicitud"), forState: UIControlState.Normal)
        }
        element.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
        return element
    }
    
    func viewForCenterOfRadialMenu(radialMenu: LNERadialMenu!) -> UIView! {
        var centerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 190, height: 190))
        centerView.backgroundColor  = UIColor.blackColor().colorWithAlphaComponent(0.2)
        return centerView
    }
    
    func radialMenu(radialMenu: LNERadialMenu!, customizationForRadialMenuView radialMenuView: UIView!) {
        var bgLayer:CALayer = CALayer()
        bgLayer.cornerRadius = 5
        bgLayer.frame = CGRect(x: (radialMenu.radialMenuView.frame.size.width-10)/2, y: (radialMenu.radialMenuView.frame.size.width-10)/2, width: 10, height: 10)
        bgLayer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2).CGColor
        radialMenu.radialMenuView.layer.insertSublayer(bgLayer, atIndex: 0)
        
        var bgLayer2:CALayer = CALayer()
        bgLayer2.cornerRadius = 2
        bgLayer2.frame = CGRect(x: (radialMenu.radialMenuView.frame.size.width-4)/2, y: (radialMenu.radialMenuView.frame.size.width-4)/2, width: 4, height: 4)
        bgLayer2.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.4).CGColor
        radialMenu.radialMenuView.layer.insertSublayer(bgLayer2, atIndex: 0)
    }
    
    func canDragRadialMenu(radialMenu: LNERadialMenu!) -> Bool {
        return false
    }
    
    // MARK: -SIDE BAR DELEGATE  ::STEP 3
    
    func buttoTapped(button:UIImageView!,withSideBar sideBar:JOSideBarMenu,label:String , id:Int){
        step = 3
        sideBar.closeSideView()
        str2 = label
        catId = id
        showMenu(3, atPoint: CGPointZero)
        btnSubcategory = UIButton(frame: CGRectMake(0, 0, btnCategoty.frame.size.width - 10, btnCategoty.frame.height - 10))
        btnSubcategory.tag = 2
        btnSubcategory.center = btnCategoty.center
        btnSubcategory.setBackgroundImage(button.image, forState: UIControlState.Normal)
        btnSubcategory.addTarget(self, action: Selector("goBack:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(btnSubcategory)
        var pop = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        pop.toValue = NSValue(CGPoint: CGPoint(x: self.frame.size.width-164, y: btnClose.center.y))
        btnSubcategory.pop_addAnimation(pop, forKey: "TEST2")
        lblIndicator.text = str2
        var pop2 = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        pop2.toValue = NSValue(CGPoint: CGPoint(x: lblIndicator.center.x-25, y: btnClose.center.y))
        lblIndicator.pop_addAnimation(pop2, forKey: "TEST3")
        var pop3 = POPSpringAnimation(propertyNamed: kPOPViewSize)
        pop3.toValue = NSValue(CGSize: CGSize(width: 100, height: lblIndicator.frame.size.height))
        lblIndicator.pop_addAnimation(pop3, forKey: "TEST4")
    }
    
    // MARK: -SUBCATEGORY DELEGATE ::STEP 4
    func buttoTapped(button: UIButton!, withCentralBar sideBar: JOCentralMenu) {
        step = 4
        sideBar.removeFromSuperview()
        btnBack.tag = 4
        btnContinue.tag = 4
        showMenu(4, atPoint: CGPointZero)
    }
    
    // MARK: -CAMERA DELEGATE ::STEP 4
    func openCamera(sender:UIButton!){
        /*JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
        imagePicker.delegate = self;
        [imagePicker showImagePickerInController:self animated:YES];*/
        var imagePicker = JSImagePickerViewController()
        imagePicker.delegate = self
        imagePicker.showImagePickerInController(self.parentViewController(), animated: true)
    }
    
    func imagePickerDidSelectImage(image: UIImage!) {
        imgReport.image = image
        btnContinue.userInteractionEnabled = true
        if type == 1 {
            btnContinue.setTitle("Crear Reporte", forState: UIControlState.Normal)
            btnContinue.backgroundColor = UIColor.orangeYI()
        }else{
            btnContinue.setTitle("Crear Solicitud", forState: UIControlState.Normal)
            btnContinue.backgroundColor = UIColor.blurYI()
        }
        btnContinue.layer.borderColor = UIColor.clearColor().CGColor
    }
    
    func configButton(step:Int){
        if step<6{
            btnContinue.setTitle("Siguiente", forState: UIControlState.Normal)
            btnContinue.backgroundColor = UIColor.clearColor()
            btnContinue.layer.borderColor = UIColor.whiteColor().CGColor
            btnContinue.layer.borderWidth = 1
            btnContinue.userInteractionEnabled = true
        }else{
            btnContinue.userInteractionEnabled = false
        }
    }
    
    // MARK: -NEXT METHODS
    
    func goContinue(sender:UIButton!){
        self.step++
        showMenu(self.step, atPoint: CGPointZero)
    }
    
    // MARK: -BACK METHODS
    func goBack(sender:UIButton!){
        switch step{
            case 2:
                labels = 1
                self.showMenu(1, atPoint: btnClose.center)
                btnCategoty.removeFromSuperview()
                if (btnSubcategory != nil){
                    btnSubcategory.removeFromSuperview()
                    btnSubcategory = nil
                }
                lblIndicator.removeFromSuperview()
                this.removeFromSuperview()
                if (this2 != nil){
                    this2.removeFromSuperview()
                    this2 = nil
                }
            case 3:
                goLbl(2)
                self.showMenu(2, atPoint: CGPointZero)
                btnSubcategory.removeFromSuperview()
                this2.removeFromSuperview()
            case 4:
                self.showMenu(3, atPoint: CGPointZero)
                mapLocation.removeFromSuperview()
                pinIcon.removeFromSuperview()
            case 5:
                self.showMenu(4, atPoint: CGPointZero)
                txtTitle.removeFromSuperview()
                txtDesc.removeFromSuperview()
            case 6:
                self.showMenu(5, atPoint: CGPointZero)
                imgReport.removeFromSuperview()
                btnAddImage.removeFromSuperview()
            default: println("Default")
        }
        self.step--
    }
    
    func goLbl(step:Int){
        switch step{
        case 2:
            lblIndicator.text = str1
            var pop3 = POPSpringAnimation(propertyNamed: kPOPViewSize)
            pop3.toValue = NSValue(CGSize: CGSize(width: 200, height: lblIndicator.frame.size.height))
            lblIndicator.pop_addAnimation(pop3, forKey: "TEST4")
            
            var pop2 = POPSpringAnimation(propertyNamed: kPOPViewCenter)
            pop2.toValue = NSValue(CGPoint: CGPoint(x: lblIndicator.center.x+25, y: btnClose.center.y))
            lblIndicator.pop_addAnimation(pop2, forKey: "TEST3")
        case 3:
            lblIndicator.text = str2
        default: println("Default")
        }
    }
    
    
    func close(){
        var an = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        an.toValue = 0
        an.springBounciness = 10
        btnClose.layer.pop_addAnimation(an, forKey: "Rotate")
        UIView.animateWithDuration(1.0, delay: 0, options: .CurveEaseOut, animations: {
            self.alpha = 0
            }, completion: { finished in
                self.removeFromSuperview()
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
