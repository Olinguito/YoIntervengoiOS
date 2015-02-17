//
//  Connection.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/5/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit
import Foundation



class Connection: NSObject {
    let db = SQLiteDB.sharedInstance()
    override init() {
        super.init()
    }
    
    // GET CATEGORIES
    func getCategories() -> NSMutableArray{
        var returnArray = NSMutableArray()
        let data = db.query("SELECT * FROM Category")
        for key in data{
            var city: Dictionary<String, String> = [:]
            if let name = key["nam_city"] {
                city["NAME"] = name.asString()
            }
            if let image = key["img_city"] {
                city["IMAGE"] = image.asString()
            }
            
            returnArray.addObject(city)
        }
        return returnArray
    }
    
    // GET SUBCATEGORIES
    func getSubcategories() -> NSMutableArray{
        var returnArray = NSMutableArray()
        let data = db.query("SELECT * FROM subcategory")
        for key in data{
            var city: Dictionary<String, String> = [:]
            if let name = key["nam_city"] {
                city["NAME"] = name.asString()
            }
            if let image = key["img_city"] {
                city["IMAGE"] = image.asString()
            }
            
            returnArray.addObject(city)
        }
        return returnArray
    }
    
    // GET LINKS
    func getLinks() -> NSMutableArray{
        var returnArray = NSMutableArray()
        let data = db.query("SELECT * FROM links")
        for key in data{
            var links: Dictionary<String, String> = [:]
            if let _id = key["id"] {
                links["ID"] = _id.asString()
            }
            if let name = key["name"] {
                links["NAME"] = name.asString()
            }
            if let icon = key["icon"] {
                links["ICON"] = "btn_add_links_" + icon.asString()
                links["BG"] = "bg_links_" + icon.asString()
            }
            returnArray.addObject(links)
        }
        return returnArray
    }
    
    
    //GET ESPECIFIC LINK
    func getLinkByID(index:Int) -> NSMutableArray{
        var returnArray = NSMutableArray()
        let query = "SELECT * FROM link where \(index)"
        let data = db.query(query)
        print(data.count)
        for key in data{
            var links: Dictionary<String, String> = [:]
            if let _id = key["id"] {
                links["ID"] = _id.asString()
            }
            if let name = key["name"] {
                links["NAME"] = name.asString()
            }
            if let icon = key["icon"] {
                links["ICON"] = "bg_links_" + icon.asString()
            }
            returnArray.addObject(links)
        }
        return returnArray
    }
    
    
    
}


