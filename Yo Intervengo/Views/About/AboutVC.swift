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
        self.lblHeader.text = "Acerca de"
        scroll = UIScrollView(frame: CGRectMake(0, 80, vW, vH - 80))
        scroll.backgroundColor = UIColor.clearColor()
        scroll.maximumZoomScale = 10
        scroll.multipleTouchEnabled = false
        self.view.addSubview(scroll)
        
        var lblInfo = UILabel()
        var text = "Reportar y solicitar una obra pública nunca fue tan fácil. Con Yo Intervengo puedes hacer un reporte de una falla en el alcantarillado, un hueco sobre la vía, la existencia de un elefante blanco o cualquier otro problema que afecte a tu comunidad. Yo Intervengo también te permitirá interactuar con tus vecinos y respaldar la solicitud de la construcción de una obra pública. ¡Empieza a reportar y respaldar con Yo Intervengo para hacer más visibles los problemas de tu comunidad! \r\n \r\n Este proyecto fue desarrollado con ♥ desde Bogotá - Colombia por: \r\n \r\n OLINGUITO \r\n \r\n Daniel Olano | Fullstack Dev \r\n Jorge Ovalle | Mobile Dev \r\n Roberto Sarmiento Jalkh | UX UI\r\n Daniel Suárez Pérez | Data Journalist \r\n \r\n"
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
