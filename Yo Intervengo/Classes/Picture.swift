//
//  Picture.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 6/3/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class Picture: NSObject {
    var id:Int!
    var idAPI:String!
    var image:UIImage!
    var urlImage:String!
    var urlThumbImage:String!
    var like:Int!
    var title:String!
    var desc:String!
    var user:String!
    
    override init() {
        id = 0
        idAPI = ""
        image = nil
        urlImage = ""
        like = 0
        title = ""
        desc = ""
        user = ""
    }
    
}
