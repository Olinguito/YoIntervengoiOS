//
//  BKColors.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/1/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: - Utils
    func bd_componentsFromColor() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
    
    func bd_hexFromColor() -> String
    {
        var components = self.bd_componentsFromColor()
        // convert into integer
        var r: Int = Int(255.0 * components.red)
        var g: Int = Int(255.0 * components.green)
        var b: Int = Int(255.0 * components.blue)
        return String(NSString(format: "%02x%02x%02x", r, g, b))
    }
    
    // MARK: - Flat colors
    class func greyLight() -> UIColor {
        return UIColor(red:0.600, green:0.600, blue:0.600, alpha: 1)
        
    }
    
    class func orangeYI() -> UIColor {
        return UIColor(red:0.929, green:0.361, blue:0.180, alpha: 1)
    }
    
    class func blurYI() -> UIColor {
        return UIColor(red:0.122, green:0.737, blue:0.859, alpha: 1)
    }
    
    class func greyDark() -> UIColor {
        return UIColor(red:0.314, green:0.314, blue:0.314, alpha: 1)
    }
    
    class func greyButtons() -> UIColor {
        return UIColor(red:0.898, green:0.898, blue:0.898, alpha: 1)
    }
    
    class func greyNav() -> UIColor {
        return UIColor(red:0.141, green:0.141, blue:0.141, alpha: 1)
    }
    
}