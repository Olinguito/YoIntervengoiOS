//
//  Type+CoreDataProperties.swift
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

extension Type {

    @NSManaged var icon: String?
    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var slug: String?
    @NSManaged var categories: NSSet?
    @NSManaged var reports: NSSet?

}
