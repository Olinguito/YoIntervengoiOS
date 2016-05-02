//
//  AddThemeColors.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/12/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import Foundation
import UIKit

extension CATransition {
    
    class func viewTransition() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        return transition
    }
}