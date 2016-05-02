//
//  ExString.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/15/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import Foundation
import UIKit

extension String {
    static func getDate(dateintro:String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'hh:mm:ss.SSS'Z'"
        let date = dateFormatter.dateFromString(dateintro)
        dateFormatter.dateFormat = "dd-MM-YYYY"
        return dateFormatter.stringFromDate(date!)
    }
}