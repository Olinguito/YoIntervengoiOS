//
//  DataService.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/1/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import Foundation


import Foundation
import UIKit
import CoreData

typealias LoginCompletionHandler      = ((logged:Bool, error:String?)->Void)?
typealias RetrievingCompletionHandler = ((error:String?)->Void)?

class DataService {
    static let sharedInstance        = DataService() // Singleton for a unique currentUser Instance
    private let managedObjectContext:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    /**
     Intinialize users on CoreData db
     */
    func initializeData(){
        if !NSUserDefaults.standardUserDefaults().boolForKey("dataInitialized") {
            print("Initializing data...")
            
            let category1 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category1.icon = "btn_reporte_buildings"
            category1.id   = 1
            category1.name = "Edificios y terrenos"
            category1.slug = "buildings"
            
            
            let category2 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category2.icon = "btn_reporte_environment"
            category2.id   = 1
            category2.name = "Medio Ambiente"
            category2.slug = "environment"
            
            
            let category3 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category3.icon = "btn_reporte_more"
            category3.id   = 1
            category3.name = "Otros"
            category3.slug = "more"
            
            
            let category4 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category4.icon = "btn_reporte_security"
            category4.id   = 1
            category4.name = "Seguridad"
            category4.slug = "security"
            
            
            let category5 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category5.icon = "btn_reporte_buildings"
            category5.id   = 1
            category5.name = "Servicios públicos"
            category5.slug = "pub-services"
            
            
            let category6 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category6.icon = "btn_reporte_mobility"
            category6.id   = 1
            category6.name = "Movilidad"
            category6.slug = "mobility"
            
            
            
            
            do{
                try managedObjectContext.save()
            }catch{
                print("Some error inserting User")
            }
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "dataInitialized")
        }
    }
}