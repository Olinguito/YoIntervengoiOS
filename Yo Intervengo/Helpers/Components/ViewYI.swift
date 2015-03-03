
//
//  BKColors.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/1/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.nextResponder()
            if parentResponder is UIViewController {
                return parentResponder as UIViewController!
            }
        }
        return nil
    }
}