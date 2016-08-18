//
//  CensusAPICodesParser.swift
//  dataPopulation
//
//  Created by Max Tkach on 8/15/16.
//  Copyright © 2016 Anvil. All rights reserved.
//

import Foundation
import CoreData

// BREAK DOWN CENSUSAPICODES.CSV TO BE ABLE TO PAUSE THE PROCESS AND PARSE THE NEEDED STATE ASAP

class CensusAPICodesParser {
    
    private let coreDataHelper = CoreDataHelper()
    
    
    func parseCodes(completion: (Bool) -> Void) {
        let operationQueue = NSOperationQueue()
        operationQueue.addOperationWithBlock {
            self.removeData("City")
            self.removeData("County") ////////////////////// REMOVE
            self.removeData("State") ////////////////////// REMOVE FOR PRODUCTION
            self.removeData("US") ////////////////////////// REMOVE
            self.removeData("DataSet")
            self.removeData("DataSetValues")
            self.preloadData()
            completion(true)
        }
    }
    
    
    private func parseCSV (contentsOfURL: NSURL, encoding: NSStringEncoding, error: NSErrorPointer) -> [TmpState : [TmpCounty]] {
        let delimiter = ","
        var items:[TmpState : [TmpCounty]] = [:]
        var statesAlreadyInItems: [String] = []
        
        if let data = NSData(contentsOfURL: contentsOfURL), let content = NSString(data: data, encoding: NSUTF8StringEncoding) {
            let lines:[String] = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()) as [String]
            for line in lines {
                var values:[String] = []
                if line != "" {
                    if line.rangeOfString("\"") != nil {
                        var textToScan: String = line
                        var value: NSString?
                        var textScanner: NSScanner = NSScanner(string: textToScan)
                        while textScanner.string != "" {
                            
                            if (textScanner.string as NSString).substringToIndex(1) == "\"" {
                                textScanner.scanLocation += 1
                                textScanner.scanUpToString("\"", intoString: &value)
                                textScanner.scanLocation += 1
                            } else {
                                textScanner.scanUpToString(delimiter, intoString: &value)
                            }
                            
                            values.append(value as! String)
                            
                            if textScanner.scanLocation < textScanner.string.characters.count {
                                textToScan = (textScanner.string as NSString).substringFromIndex(textScanner.scanLocation + 1)
                            } else {
                                textToScan = ""
                            }
                            
                            textScanner = NSScanner(string: textToScan)
                        }
                        
                    } else {
                        values = line.componentsSeparatedByString(delimiter)
                    }
                    
                    let county = TmpCounty()
                    county.code = values[2]
                    county.name = values[3]
                    
                    if statesAlreadyInItems.contains(values[0]) {
                        for state in items.keys {
                            if state.abbreviation == values[0] {
                                items[state]?.append(county)
                                break
                            }
                        }
                    } else {
                        statesAlreadyInItems.append(values[0])
                        let state = TmpState()
                        state.abbreviation = values[0]
                        state.code = values[1]
                        items[state] = [county]
                    }
                }
            }
        }
        return items
    }
    
    
    private func preloadData() {
        let date = NSDate()
        
        if let contentsOfURL = NSBundle.mainBundle().URLForResource("CensusAPICodes", withExtension: "csv") {
            
            let managedObjectContext = self.coreDataHelper.managedObjectContextForBackgroundThread
            var error: NSError?
            
            let usEntity = NSEntityDescription.insertNewObjectForEntityForName(Hints.us, inManagedObjectContext: managedObjectContext) as! US
            
            let items = self.parseCSV(contentsOfURL, encoding: NSUTF8StringEncoding, error: &error)
            if !items.isEmpty {
                
                
                for (tmpState, tmpCounties) in items {
                    
                    let stateEntity = NSEntityDescription.insertNewObjectForEntityForName(Hints.state, inManagedObjectContext: managedObjectContext) as! State
                    stateEntity.abbreviation = tmpState.abbreviation
                    stateEntity.code = tmpState.code
                    stateEntity.us = usEntity
                    usEntity.states?.insert(stateEntity)
                    
                    for tmpCounty in tmpCounties {
                        let countyEntity = NSEntityDescription.insertNewObjectForEntityForName(Hints.county, inManagedObjectContext: managedObjectContext) as! County
                        countyEntity.name = tmpCounty.name
                        countyEntity.code = tmpCounty.code
                        countyEntity.stateCode = stateEntity.code
                        countyEntity.state = stateEntity
                        stateEntity.counties?.insert(countyEntity)
                        
                        do {
                            try managedObjectContext.save()
                        } catch {
                            print("Error inserting county: \(error)") //////////////////////////
                        }
                    }
                }
            }
        }
        let difference = date.timeIntervalSinceNow /////////////// REMOVE - EXECUTION SPEED
        print(difference) //////////////////////////////////////// REMOVE - EXECUTION SPEED
    }
    
    
    private func removeData(entity: String) { // DELETE IN THE PRODUCTION VERSION, FUNCTION EXISTS FOR TESTING ONLY
        print("Removing from CoreData: \(entity)")
        let managedObjectContext = self.coreDataHelper.managedObjectContextForBackgroundThread
        let fetchRequest = NSFetchRequest(entityName: entity)
        
        do {
            let items = try managedObjectContext.executeFetchRequest(fetchRequest)
            print("\(entity) count: \(items.count)")
            for item in items {
                managedObjectContext.deleteObject(item as! NSManagedObject)
            }
        } catch {
            print("Error getting menu item: \(error)")
            return
        }
    }
    
    
    func printCityData() { // DELETE IN THE PRODUCTION VERSION, FUNCTION EXISTS FOR TESTING ONLY
        print("Printing city names")
        let managedObjectContext = self.coreDataHelper.managedObjectContextForBackgroundThread
        let fetchRequest = NSFetchRequest(entityName: Hints.city)
        
        do {
            let items = try managedObjectContext.executeFetchRequest(fetchRequest)
            print("Cities count: \(items.count)")
            for item in items {
                let cityItem = item as! City
                print(cityItem.name)
            }
        } catch {
            print("Error getting menu item: \(error)")
            return
        }
    }

    
}


private class TmpState: NSObject {
    var code: String?
    var abbreviation: String?
}


private class TmpCounty: NSObject {
    var code: String?
    var name: String?
}

