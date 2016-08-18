//
//  DataSetValues+CoreDataProperties.swift
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

extension DataSetValues {

    @NSManaged var absoluteValue: String?
    @NSManaged var code: String?
    @NSManaged var name: String?
    @NSManaged var percentValue: String?
    @NSManaged var dataSet: DataSet?

}
