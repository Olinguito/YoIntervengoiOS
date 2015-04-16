//
//  YIPin.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 4/16/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    
    // MARK: - Flat colors
    class func getPin(type:Int, Category:Int) -> UIImage {
        println("entro con \(type) y con \(Category)")
        var bg = type == 1 ? UIImage(named: "Pin@2x")!:UIImage(named: "Pin2@2x")!
        var logo = UIImage(named: "ic-0\(Category)@2x.png")!
        UIGraphicsBeginImageContextWithOptions(bg.size, false, 2)
        bg.drawInRect(CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: bg.size.width, height: bg.size.height)))
        logo.drawInRect(CGRect(origin: CGPoint(x: (bg.size.width-logo.size.width)/2, y: 15), size: CGSize(width: 30, height: 30)))
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}