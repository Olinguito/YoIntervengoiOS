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
        if !NSUserDefaults.standardUserDefaults().boolForKey(QDataIninitalizedNotification) {
            print("Initializing data...")
            
            let type1 = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: managedObjectContext) as! Type
            type1.icon = "repo"
            type1.id   = 1
            type1.name = "Reporte"
            type1.slug = "report"
            
            let type2 = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: managedObjectContext) as! Type
            type2.icon = "solicitud"
            type2.id   = 2
            type2.name = "Solicitud"
            type2.slug = "ask"
            
            
            
            let category1 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category1.icon = "btn_report_buildings"
            category1.id   = 1
            category1.name = "Edificios y terrenos"
            category1.slug = "buildings"
            category1.type = type1
            
            let category2 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category2.icon = "btn_report_environment"
            category2.id   = 1
            category2.name = "Medio Ambiente"
            category2.slug = "environment"
            category2.type = type1
            
            let category3 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category3.icon = "btn_report_more"
            category3.id   = 1
            category3.name = "Otros"
            category3.slug = "more"
            category3.type = type1
            
            let category4 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category4.icon = "btn_report_security"
            category4.id   = 1
            category4.name = "Seguridad"
            category4.slug = "security"
            category4.type = type1
            
            let category5 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category5.icon = "btn_report_buildings"
            category5.id   = 1
            category5.name = "Servicios públicos"
            category5.slug = "pub-services"
            category5.type = type1
            
            let category6 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category6.icon = "btn_report_mobility"
            category6.id   = 1
            category6.name = "Movilidad"
            category6.slug = "mobility"
            category6.type = type1
            
            
            let category21 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category21.icon = "btn_ask_buildings"
            category21.id   = 1
            category21.name = "Edificios y terrenos"
            category21.slug = "buildings"
            category21.type = type2
            
            let category22 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category22.icon = "btn_ask_environment"
            category22.id   = 1
            category22.name = "Medio Ambiente"
            category22.slug = "environment"
            category22.type = type2
            
            let category23 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category23.icon = "btn_ask_more"
            category23.id   = 1
            category23.name = "Otros"
            category23.slug = "more"
            category23.type = type2
            
            let category24 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category24.icon = "btn_ask_security"
            category24.id   = 1
            category24.name = "Seguridad"
            category24.slug = "security"
            category24.type = type2
            
            let category25 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category25.icon = "btn_ask_buildings"
            category25.id   = 1
            category25.name = "Servicios públicos"
            category25.slug = "pub-services"
            category25.type = type2
            
            let category26 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category26.icon = "btn_ask_mobility"
            category26.id   = 1
            category26.name = "Movilidad"
            category26.slug = "mobility"
            category26.type = type2
            
            
            
            do{
                try managedObjectContext.save()
            }catch{
                print("Some error inserting User")
            }
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: QDataIninitalizedNotification)
        }
    }
}