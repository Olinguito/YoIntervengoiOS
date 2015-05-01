//
//  ReportVC.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/12/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class ReportVC: GenericViewController {

    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btnReport: UIButton!
    
    var selected:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnReport.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        btnReport.layer.cornerRadius = 5
        
        btn1.tag = 1
        btn2.tag = 2
        btn3.tag = 3

        configure(btn1)
        configure(btn2)
        configure(btn3)
        
        btn1.addTarget(self, action: Selector("setValue:"), forControlEvents: UIControlEvents.TouchUpInside)
        btn2.addTarget(self, action: Selector("setValue:"), forControlEvents: UIControlEvents.TouchUpInside)
        btn3.addTarget(self, action: Selector("setValue:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        lblHeader.text = "Denuncia"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.showNavBar(true)
    }
    
    func configure(sender:UIButton!){
        sender.titleLabel?.font = UIFont(name: "Roboto-Light", size: 18)
        sender.setTitleColor(UIColor.greyDark(), forState: UIControlState.Normal)
        sender.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.greyLight().CGColor
    }
    
    func setValue(sender:UIButton){
        configure(btn1)
        configure(btn2)
        configure(btn3)
        sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        sender.backgroundColor = UIColor.greyLight()
        selected = sender.tag
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
