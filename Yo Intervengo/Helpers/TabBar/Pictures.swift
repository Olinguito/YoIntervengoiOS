//
//  Pictures.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/4/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class Pictures: UIView, PicContainerDelegate {
    var picCont:PicContainer!
    var frame2:CGRect!
    var view:UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(index:Int, frame:CGRect, ini:CGFloat) {
        super.init(frame:CGRectZero)
        frame2 = frame
        var ms = NSMutableArray()
        self.backgroundColor = UIColor.whiteColor()
        ms.addObject(UIImage(named: "bg1")!)
        picCont = PicContainer(frame: CGRect(x: 0, y: 0, width: frame.width, height: ((frame.height - ini))-55), array: ms)
        picCont.delegate = self
        self.addSubview(picCont)
        
        self.frame = CGRect(x: 0, y: 0, width: frame.width, height: (frame.height - CGFloat(ini))-55)
    }
    
    func picTapped(index: Int) {
        print("Entra aca?")
        view = UIView(frame: frame2)
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.85)
        
        self.superview?.superview?.superview?.addSubview(view)
        
        let grad1 = Gradient(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100), type: "Top")
        view.addSubview(grad1)
        let grad2 = Gradient(frame: CGRect(x: 0, y: view.frame.height-100, width: view.frame.width, height: 100), type: "Bottom")
        view.addSubview(grad2)
        
        
        var image = UIImageView(image: UIImage(named: "bg1"))
        image.center.y = view.center.y
        view.addSubview(image)
        
        var panel = Panel()
        panel.center.x = view.center.x
        panel.frame.origin.y = view.frame.maxY - 40
        view.addSubview(panel)
        
        var desc = UILabel(frame: CGRect(x: 25, y: (panel.frame.minY-20) , width: 270, height: 14))
        desc.text = "No se ven a los obreros trabajando a ninguna hora."
        desc.font = UIFont(name: "Roboto-LightItalic", size: 12)
        desc.textColor = UIColor.whiteColor()
        view.addSubview(desc)
        
        var userDate = UILabel(frame: CGRect(x: 25, y: (desc.frame.minY-20) , width: 270, height: 14))

        var txt1 = "SandroNino_Bravo " as NSString
        var txt2 = "Ene. 26, 2014 - 2:25pm" as NSString
        
        var myMutableString = NSMutableAttributedString(string: txt1+txt2, attributes: [NSFontAttributeName:UIFont(name: "Roboto-Light", size: 12)!])
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeYI(), range: NSRange(location:0,length:txt1.length))
        myMutableString.addAttribute(NSFontAttributeName, value:UIFont(name: "Roboto-Light", size: 12)!, range: NSRange(location:0,length:txt1.length))
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSRange(location:txt1.length,length:txt2.length))
        myMutableString.addAttribute(NSFontAttributeName, value:UIFont(name: "Roboto-Light", size: 10)!, range: NSRange(location:txt1.length,length:txt2.length))
        
        userDate.attributedText = myMutableString
        
        view.addSubview(userDate)
//        userDate.setAttributedTitle(myMutableString, forState: .Normal)
        
        var close = UIButton(frame: CGRect(x: view.frame.width - 40, y:20, width: 40, height: 40))
        close.setImage(UIImage(named: "btnClose"), forState: UIControlState.Normal)
        close.addTarget(self, action: Selector("close:"), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(close)
        
    }
    
    func close(sender:UIButton){
        view.removeFromSuperview()
    }
    
}