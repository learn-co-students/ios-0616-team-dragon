//
//  City+CoreDataProperties.swift
//  dataPopulation
//
//  Created by Max Tkach on 8/13/16.
//  Copyright © 2016 Anvil. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension City {

    @NSManaged var code: String?
    @NSManaged var name: String?
    @NSManaged var county: County?
    @NSManaged var dataSets: Set<DataSet>?
    @NSManaged var state: State?

}
