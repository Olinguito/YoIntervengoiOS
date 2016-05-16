//
//  Category+CoreDataProperties.swift
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

extension Category {

    @NSManaged var icon: String?
    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var slug: String?
    @NSManaged var subcategories: NSSet?
    @NSManaged var parent: Category?
    @NSManaged var type: Type?
    @NSManaged var reportsByCategoy: Report?
    @NSManaged var reportsBySubCategoy: Report?

}