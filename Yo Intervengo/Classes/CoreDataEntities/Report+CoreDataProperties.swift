//
//  Report+CoreDataProperties.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/9/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Report {

    @NSManaged var date: NSDate?
    @NSManaged var desc: String?
    @NSManaged var title: String?
    @NSManaged var photo: String?
    @NSManaged var type: Type?
    @NSManaged var category: Category?
    @NSManaged var subcategoty: Category?

}
