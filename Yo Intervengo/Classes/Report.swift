//
//  Report.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 6/2/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit
import MapKit

class Report: NSObject {
    var id:Int!
    var idAPI:String!
    var color:UIColor!
    var type:Int!
    var category:Category!
    var image:UIImage!
    var urlImage:String!
    var title:String!
    var desc:String!
    var followers:Int!
    var address:String!
    var location:CLLocationCoordinate2D!
    
    
    init(type:Int) {
        super.init()
        id = 0
        idAPI = ""
        self.type = type
        category = Category()
        image = nil
        urlImage = ""
        title = ""
        desc = ""
        followers = 0
        address = ""
        location = CLLocationCoordinate2D()
        self.color = self.type == 1 ? UIColor.orangeYI() : UIColor.blurYI()
    }
    
}
