//
//  Category.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/29/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class Category: NSObject {
    var id:Int!
    var idAPI:String!
    var slug:String!
    var name:String!
    var icon:String!
    var parentId:Int!
    var parentAPI:String!
    var parentName:String!
    
    
    
    override init() {
        id = 0
        idAPI = ""
        slug = ""
        name = ""
        icon = ""
        parentId = 0
        parentAPI = ""
        parentName = ""
    }
    
    init(id:Int, slug:String, name:String, icon:String, idAPI:String,parentId:Int,parentAPI:String,parentName:String) {
        self.id = id
        self.slug = slug
        self.name = name
        self.icon = icon
        self.idAPI = idAPI
        self.parentId = parentId
        self.parentAPI = parentAPI
        self.parentName = parentName
    }
    
    func getAPIid(idDB:Int) -> String{
        return "hola mundo"
    }
    
    func getidDB(idAPI:String) -> Int{
        return 2
    }
}
