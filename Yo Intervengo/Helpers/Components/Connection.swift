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
    
    //GET CATEGGORY
    
    func getCategoryByDBId(idDB:Int) -> Category {
        var category = Category()
        let data = db.query("select a.id as idSub, a.name as nameSub, a.apiID as APISub, b.id as idCat, b.name as nameCat, b.icon as icon, b.apiID as APICat  from subcategory a,category b where a.category = b.id and a.id = \(idDB)")
        let row = data[0]
        if let _id = row["idSub"] {
            category.id = _id.asInt()
        }
        if let icon = row["icon"] {
            category.slug = icon.asString()
            category.icon = icon.asString()
        }
        if let name = row["nameSub"] {
            category.name = name.asString()
        }
        if let api = row["APISub"]{
            category.idAPI = api.asString()
        }
        if let _idCat = row["idCat"]{
            category.parentId = _idCat.asInt()
        }
        if let nameCat = row["nameCat"]{
            category.parentName = nameCat.asString()
        }
        if let apiCat = row["apiID"]{
            category.parentAPI = apiCat.asString()
        }
        return category
    }
    
    
    // GET CATEGORIES
    func getCategory(id:Int) -> Category{
        var returnArray = NSMutableArray()
        let data = db.query("SELECT * FROM Category where id = \(id)")
        let row = data[0]
        var category = Category()
            if let _id = row["id"] {
                category.id = _id.asInt()
            }
            if let name = row["name"] {
                category.name = name.asString()
            }
            if let image = row["icon"] {
                category.icon = image.asString()
            }
        return category
    }
    
    // GET CATEGORIES
    func getCategories(report:Bool) -> NSMutableArray{
        var returnArray = NSMutableArray()
        let data = db.query("SELECT * FROM Category ORDER BY _order")
        for key in data{
            var city: Dictionary<String, String> = [:]
            if let _id = key["id"] {
                city["ID"] = _id.asString()
            }
            if let name = key["name"] {
                city["NAME"] = name.asString()
            }
            if let image = key["icon"] {
                city["ICON"] = report ? "btn_reporte_" + image.asString() : "btn_solicitud_" + image.asString()
            }
            returnArray.addObject(city)
        }
        return returnArray
    }
    
    // GET SUBCATEGORIES
    func getSubcategories(idCategory:Int) -> NSMutableArray{
        var returnArray = NSMutableArray()
        let data = db.query("SELECT * FROM subcategory where category = \(idCategory)")
        for key in data{
            var category = Category()
            if let id = key["id"] {
                category.id = id.asInt()
            }
            if let name = key["name"] {
                category.name = name.asString()
            }
            returnArray.addObject(category)
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


