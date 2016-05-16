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
            
            // ===========================================================================
            
            let category1       = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category1.icon      = "btn_report_buildings"
            category1.id        = 1
            category1.name      = "Edificios y terrenos"
            category1.slug      = "buildings"
            category1.type      = type1
            
            let subcategory1    = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory1.id     = 1
            subcategory1.name   = "Parques"
            subcategory1.slug   = "parks"
            subcategory1.parent = category1
            
            let subcategory2    = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory2.id     = 2
            subcategory2.name   = "Complejos deportivos"
            subcategory2.slug   = "sport_complex"
            subcategory2.parent = category1
            
            let subcategory3    = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory3.id     = 3
            subcategory3.name   = "Edificios"
            subcategory3.slug   = "builds"
            subcategory3.parent = category1
            
            let subcategory4    = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory4.id     = 4
            subcategory4.name   = "Elefante blanco"
            subcategory4.slug   = "white_elephant"
            subcategory4.parent = category1
            
            let subcategory5    = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory5.id     = 5
            subcategory5.name   = "Viviendas de interés social"
            subcategory5.slug   = "social_housing"
            subcategory5.parent = category1
            
            let subcategory6    = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory6.id     = 6
            subcategory6.name   = "Centros educativos"
            subcategory6.slug   = "schools"
            subcategory6.parent = category1
            
            let subcategory7    = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory7.id     = 7
            subcategory7.name   = "Centros de salud"
            subcategory7.slug   = "hospitals"
            subcategory7.parent = category1
            
            let subcategory8    = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory8.id     = 8
            subcategory8.name   = "Otros"
            subcategory8.slug   = "other"
            subcategory8.parent = category1
            
            // ===========================================================================
            
            let category2 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category2.icon = "btn_report_environment"
            category2.id   = 1
            category2.name = "Medio Ambiente"
            category2.slug = "environment"
            category2.type = type1
            
            
            let subcategory9 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory9.id   = 1
            subcategory9.name = "Contaminación"
            subcategory9.slug = "contamination"
            subcategory9.parent = category2
            
            let subcategory10 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory10.id   = 2
            subcategory10.name = "Aguas estancadas"
            subcategory10.slug = "backwaters"
            subcategory10.parent = category2
            
            let subcategory11 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory11.id   = 3
            subcategory11.name = "Quemas ilegales"
            subcategory11.slug = "illegal_burnings"
            subcategory11.parent = category2
            
            let subcategory12 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory12.id   = 4
            subcategory12.name = "Tala ilegal"
            subcategory12.slug = "illegal_logging"
            subcategory12.parent = category2
            
            let subcategory13 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory13.id   = 5
            subcategory13.name = "Prevención de catástrofes ambientales"
            subcategory13.slug = "disasters_prevention"
            subcategory13.parent = category2
            
            let subcategory14 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory14.id   = 6
            subcategory14.name = "Desviación y ríos"
            subcategory14.slug = "rivers"
            subcategory14.parent = category2
            
            let subcategory15 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory15.id   = 7
            subcategory15.name = "Otros"
            subcategory15.slug = "other"
            subcategory15.parent = category2
            
            
            // ===========================================================================
            
            let category3 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category3.icon = "btn_report_more"
            category3.id   = 1
            category3.name = "Otros"
            category3.slug = "more"
            category3.type = type1
            
            
            let subcategory16 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory16.id   = 1
            subcategory16.name = "Otros"
            subcategory16.slug = "other"
            subcategory16.parent = category3
            
            // ===========================================================================
            
            let category4 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category4.icon = "btn_report_security"
            category4.id   = 1
            category4.name = "Seguridad"
            category4.slug = "security"
            category4.type = type1
            
            let subcategory17 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory17.id   = 1
            subcategory17.name = "Robo"
            subcategory17.slug = "steal"
            subcategory17.parent = category4
            
            let subcategory18 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory18.id   = 2
            subcategory18.name = "Cámaras de seguridad"
            subcategory18.slug = "security_cams"
            subcategory18.parent = category4
            
            let subcategory19 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory19.id   = 3
            subcategory19.name = "Grupos ilegales/bandas"
            subcategory19.slug = "gangs"
            subcategory19.parent = category4
            
            let subcategory20 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory20.id   = 4
            subcategory20.name = "Expendios ilegales"
            subcategory20.slug = "other"
            subcategory20.parent = category4
            
            let subcategory21 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory21.id   = 5
            subcategory21.name = "Presencia de actores armados"
            subcategory21.slug = "other"
            subcategory21.parent = category4
            
            let subcategory22 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory22.id   = 6
            subcategory22.name = "Más presencia policial"
            subcategory22.slug = "police"
            subcategory22.parent = category4
            
            let subcategory23 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory23.id   = 7
            subcategory23.name = "Otros"
            subcategory23.slug = "other"
            subcategory23.parent = category4
            
            // ===========================================================================
            
            let category5 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category5.icon = "btn_report_buildings"
            category5.id   = 1
            category5.name = "Servicios públicos"
            category5.slug = "pub-services"
            category5.type = type1
            
            let subcategory24 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory24.id   = 1
            subcategory24.name = "Energia"
            subcategory24.slug = "energy"
            subcategory24.parent = category5
            
            
            let subcategory25 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory25.id   = 2
            subcategory25.name = "Telefonía"
            subcategory25.slug = "phone"
            subcategory25.parent = category5
            
            
            let subcategory26 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory26.id   = 3
            subcategory26.name = "Internet"
            subcategory26.slug = "internet"
            subcategory26.parent = category5
            
            
            let subcategory27 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory27.id   = 4
            subcategory27.name = "Basuras"
            subcategory27.slug = "trash"
            subcategory27.parent = category5
            
            
            let subcategory28 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory28.id   = 5
            subcategory28.name = "Alumbrado"
            subcategory28.slug = "light"
            subcategory28.parent = category5
            
            let subcategory29 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory29.id   = 6
            subcategory29.name = "Acueducto"
            subcategory29.slug = "aqueduct"
            subcategory29.parent = category5
            
            let subcategory30 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory30.id   = 7
            subcategory30.name = "Alcantarillado"
            subcategory30.slug = "sewerage"
            subcategory30.parent = category5
            
            let subcategory31 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory31.id   = 1
            subcategory31.name = "Gas"
            subcategory31.slug = "gas"
            subcategory31.parent = category5
            
            let subcategory32 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory32.id   = 1
            subcategory32.name = "Otros"
            subcategory32.slug = "other"
            subcategory32.parent = category5
            
            // ===========================================================================
            
            let category6 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category6.icon = "btn_report_mobility"
            category6.id   = 1
            category6.name = "Movilidad"
            category6.slug = "mobility"
            category6.type = type1
            
            let subcategory33 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory33.id   = 1
            subcategory33.name = "Andén"
            subcategory33.slug = "sidewalk"
            subcategory33.parent = category6
            
            let subcategory34 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory34.id   = 2
            subcategory34.name = "Ciclo-ruta"
            subcategory34.slug = "bikelane"
            subcategory34.parent = category6
            
            let subcategory35 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory35.id   = 3
            subcategory35.name = "Señales de tránsito"
            subcategory35.slug = "traffic_signal"
            subcategory35.parent = category6
            
            let subcategory36 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory36.id   = 4
            subcategory36.name = "Puente peatonal"
            subcategory36.slug = "human_bridge"
            subcategory36.parent = category6
            
            let subcategory37 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory37.id   = 5
            subcategory37.name = "Puente vehicular"
            subcategory37.slug = "car_bridge"
            subcategory37.parent = category6
            
            let subcategory38 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory38.id   = 6
            subcategory38.name = "Cruce peligroso"
            subcategory38.slug = "dangerous_intersection"
            subcategory38.parent = category6
            
            let subcategory39 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory39.id   = 7
            subcategory39.name = "Semáforos"
            subcategory39.slug = "traffic_light"
            subcategory39.parent = category6
            
            let subcategory40 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory40.id   = 8
            subcategory40.name = "Difícil acceso"
            subcategory40.slug = "hard_access"
            subcategory40.parent = category6
            
            let subcategory41 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory41.id   = 9
            subcategory41.name = "Vía en mal estado"
            subcategory41.slug = "bad_asphalt"
            subcategory41.parent = category6
            
            let subcategory42 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory42.id   = 10
            subcategory42.name = "Robo de alcantarilla"
            subcategory42.slug = "sewerage_steal"
            subcategory42.parent = category6
            
            let subcategory43 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory43.id   = 11
            subcategory43.name = "Pavimentación"
            subcategory43.slug = "asphalt"
            subcategory43.parent = category6
            
            let subcategory44 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory44.id   = 12
            subcategory44.name = "Alcantarilla"
            subcategory44.slug = "sewerage"
            subcategory44.parent = category6
            
            let subcategory45 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory45.id   = 13
            subcategory45.name = "Hueco"
            subcategory45.slug = "pothole"
            subcategory45.parent = category6
            
            let subcategory46 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            subcategory46.id   = 14
            subcategory46.name = "Otros"
            subcategory46.slug = "other"
            subcategory46.parent = category6
            
            
            // ===========================================================================
            
            let category21 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category21.icon = "btn_ask_buildings"
            category21.id   = 1
            category21.name = "Edificios y terrenos"
            category21.slug = "buildings"
            category21.type = type2
            
            let _subcategory1 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory1.id   = 1
            _subcategory1.name = "Parques"
            _subcategory1.slug = "parks"
            _subcategory1.parent = category21
            
            let _subcategory2 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory2.id   = 2
            _subcategory2.name = "Complejos deportivos"
            _subcategory2.slug = "sport_complex"
            _subcategory2.parent = category21
            
            let _subcategory3 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory3.id   = 3
            _subcategory3.name = "Edificios"
            _subcategory3.slug = "builds"
            _subcategory3.parent = category21
            
            let _subcategory4 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory4.id   = 4
            _subcategory4.name = "Elefante blanco"
            _subcategory4.slug = "white_elephant"
            _subcategory4.parent = category21
            
            let _subcategory5 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory5.id   = 5
            _subcategory5.name = "Viviendas de interés social"
            _subcategory5.slug = "social_housing"
            _subcategory5.parent = category21
            
            let _subcategory6 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory6.id   = 6
            _subcategory6.name = "Centros educativos"
            _subcategory6.slug = "schools"
            _subcategory6.parent = category21
            
            let _subcategory7 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory7.id   = 7
            _subcategory7.name = "Centros de salud"
            _subcategory7.slug = "hospitals"
            _subcategory7.parent = category21
            
            let _subcategory8    = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory8.id     = 8
            _subcategory8.name   = "Otros"
            _subcategory8.slug   = "other"
            _subcategory8.parent = category21
            
            // ===========================================================================
            
            let category22 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category22.icon = "btn_ask_environment"
            category22.id   = 1
            category22.name = "Medio Ambiente"
            category22.slug = "environment"
            category22.type = type2
            
            let _subcategory9 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory9.id   = 1
            _subcategory9.name = "Contaminación"
            _subcategory9.slug = "contamination"
            _subcategory9.parent = category22
            
            let _subcategory10 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory10.id   = 2
            _subcategory10.name = "Aguas estancadas"
            _subcategory10.slug = "backwaters"
            _subcategory10.parent = category22
            
            let _subcategory11 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory11.id   = 3
            _subcategory11.name = "Quemas ilegales"
            _subcategory11.slug = "illegal_burnings"
            _subcategory11.parent = category22
            
            let _subcategory12 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory12.id   = 4
            _subcategory12.name = "Tala ilegal"
            _subcategory12.slug = "illegal_logging"
            _subcategory12.parent = category22
            
            let _subcategory13 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory13.id   = 5
            _subcategory13.name = "Prevención de catástrofes ambientales"
            _subcategory13.slug = "disasters_prevention"
            _subcategory13.parent = category22
            
            let _subcategory14 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory14.id   = 6
            _subcategory14.name = "Desviación y ríos"
            _subcategory14.slug = "rivers"
            _subcategory14.parent = category22
            
            let _subcategory15 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory15.id   = 7
            _subcategory15.name = "Otros"
            _subcategory15.slug = "other"
            _subcategory15.parent = category22
            
            // ===========================================================================
            
            let category23 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category23.icon = "btn_ask_more"
            category23.id   = 1
            category23.name = "Otros"
            category23.slug = "more"
            category23.type = type2
            
            let _subcategory16 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory16.id   = 1
            _subcategory16.name = "Otros"
            _subcategory16.slug = "other"
            _subcategory16.parent = category3
            
            // ===========================================================================
            
            let category24 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category24.icon = "btn_ask_security"
            category24.id   = 1
            category24.name = "Seguridad"
            category24.slug = "security"
            category24.type = type2
            
            let _subcategory17 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory17.id   = 1
            _subcategory17.name = "Robo"
            _subcategory17.slug = "steal"
            _subcategory17.parent = category24
            
            let _subcategory18 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory18.id   = 2
            _subcategory18.name = "Cámaras de seguridad"
            _subcategory18.slug = "security_cams"
            _subcategory18.parent = category24
            
            let _subcategory19 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory19.id   = 3
            _subcategory19.name = "Grupos ilegales/bandas"
            _subcategory19.slug = "gangs"
            _subcategory19.parent = category24
            
            let _subcategory20 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory20.id   = 4
            _subcategory20.name = "Expendios ilegales"
            _subcategory20.slug = "other"
            _subcategory20.parent = category24
            
            let _subcategory21 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory21.id   = 5
            _subcategory21.name = "Presencia de actores armados"
            _subcategory21.slug = "other"
            _subcategory21.parent = category24
            
            let _subcategory22 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory22.id   = 6
            _subcategory22.name = "Más presencia policial"
            _subcategory22.slug = "police"
            _subcategory22.parent = category24
            
            let _subcategory23 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory23.id   = 7
            _subcategory23.name = "Otros"
            _subcategory23.slug = "other"
            _subcategory23.parent = category24
            
            // ===========================================================================
            
            let category25 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category25.icon = "btn_ask_buildings"
            category25.id   = 1
            category25.name = "Servicios públicos"
            category25.slug = "pub-services"
            category25.type = type2
            
            let _subcategory24 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory24.id   = 1
            _subcategory24.name = "Energia"
            _subcategory24.slug = "energy"
            _subcategory24.parent = category25
            
            
            let _subcategory25 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory25.id   = 2
            _subcategory25.name = "Telefonía"
            _subcategory25.slug = "phone"
            _subcategory25.parent = category25
            
            
            let _subcategory26 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory26.id   = 3
            _subcategory26.name = "Internet"
            _subcategory26.slug = "internet"
            _subcategory26.parent = category25
            
            
            let _subcategory27 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory27.id   = 4
            _subcategory27.name = "Basuras"
            _subcategory27.slug = "trash"
            _subcategory27.parent = category25
            
            
            let _subcategory28 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory28.id   = 5
            _subcategory28.name = "Alumbrado"
            _subcategory28.slug = "light"
            _subcategory28.parent = category25
            
            let _subcategory29 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory29.id   = 6
            _subcategory29.name = "Acueducto"
            _subcategory29.slug = "aqueduct"
            _subcategory29.parent = category25
            
            let _subcategory30 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory30.id   = 7
            _subcategory30.name = "Alcantarillado"
            _subcategory30.slug = "sewerage"
            _subcategory30.parent = category25
            
            let _subcategory31 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory31.id   = 1
            _subcategory31.name = "Gas"
            _subcategory31.slug = "gas"
            _subcategory31.parent = category25
            
            let _subcategory32 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory32.id   = 1
            _subcategory32.name = "Otros"
            _subcategory32.slug = "other"
            _subcategory32.parent = category25
            
            // ===========================================================================
            
            
            let category26 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            category26.icon = "btn_ask_mobility"
            category26.id   = 1
            category26.name = "Movilidad"
            category26.slug = "mobility"
            category26.type = type2
            
            let _subcategory33 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory33.id   = 1
            _subcategory33.name = "Andén"
            _subcategory33.slug = "sidewalk"
            _subcategory33.parent = category26
            
            let _subcategory34 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory34.id   = 2
            _subcategory34.name = "Ciclo-ruta"
            _subcategory34.slug = "bikelane"
            _subcategory34.parent = category26
            
            let _subcategory35 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory35.id   = 3
            _subcategory35.name = "Señales de tránsito"
            _subcategory35.slug = "traffic_signal"
            _subcategory35.parent = category26
            
            let _subcategory36 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory36.id   = 4
            _subcategory36.name = "Puente peatonal"
            _subcategory36.slug = "human_bridge"
            _subcategory36.parent = category26
            
            let _subcategory37 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory37.id   = 5
            _subcategory37.name = "Puente vehicular"
            _subcategory37.slug = "car_bridge"
            _subcategory37.parent = category26
            
            let _subcategory38 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory38.id   = 6
            _subcategory38.name = "Cruce peligroso"
            _subcategory38.slug = "dangerous_intersection"
            _subcategory38.parent = category26
            
            let _subcategory39 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory39.id   = 7
            _subcategory39.name = "Semáforos"
            _subcategory39.slug = "traffic_light"
            _subcategory39.parent = category26
            
            let _subcategory40 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory40.id   = 8
            _subcategory40.name = "Difícil acceso"
            _subcategory40.slug = "hard_access"
            _subcategory40.parent = category26
            
            let _subcategory41 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory41.id   = 9
            _subcategory41.name = "Vía en mal estado"
            _subcategory41.slug = "bad_asphalt"
            _subcategory41.parent = category26
            
            let _subcategory42 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory42.id   = 10
            _subcategory42.name = "Robo de alcantarilla"
            _subcategory42.slug = "sewerage_steal"
            _subcategory42.parent = category26
            
            let _subcategory43 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory43.id   = 11
            _subcategory43.name = "Pavimentación"
            _subcategory43.slug = "asphalt"
            _subcategory43.parent = category26
            
            let _subcategory44 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory44.id   = 12
            _subcategory44.name = "Alcantarilla"
            _subcategory44.slug = "sewerage"
            _subcategory44.parent = category26
            
            let _subcategory45 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory45.id   = 13
            _subcategory45.name = "Hueco"
            _subcategory45.slug = "pothole"
            _subcategory45.parent = category26
            
            let _subcategory46 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as! Category
            _subcategory46.id   = 14
            _subcategory46.name = "Otros"
            _subcategory46.slug = "other"
            _subcategory46.parent = category26
            
            do{
                try managedObjectContext.save()
            }catch{
                print("Some error inserting User")
            }
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: QDataIninitalizedNotification)
        }
    }
}