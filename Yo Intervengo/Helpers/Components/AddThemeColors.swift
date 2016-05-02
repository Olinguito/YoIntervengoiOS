//
//  AddThemeColors.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/12/15.
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
        let components = self.bd_componentsFromColor()
        // convert into integer
        let r: Int = Int(255.0 * components.red)
        let g: Int = Int(255.0 * components.green)
        let b: Int = Int(255.0 * components.blue)
        return String(NSString(format: "%02x%02x%02x", r, g, b))
    }
    
    // MARK: - Flat colors
    class func addThemeBg() -> UIColor {
        return UIColor.whiteColor().colorWithAlphaComponent(0.8)
        
    }
    
    class func addThemeContrast() -> UIColor {
        return UIColor(red:0.349, green:0.349, blue:0.349, alpha: 1)
        
    }
    
    
    
}