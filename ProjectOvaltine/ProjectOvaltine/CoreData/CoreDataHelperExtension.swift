//
//  CoreDataExtension.swift
//  dataPopulation
//
//  Created by Max Tkach on 8/17/16.
//  Copyright © 2016 Anvil. All rights reserved.
//

import Foundation
import CoreData


extension CoreDataHelper {
    
    func processData(data: [[String]], countyCode: String?, stateCode: String?, type: String, completion:(Bool) -> Void) {
        
        var totalCommuteTime: Double? = nil // Special case handling, calculating average commute time
        var totalNumberOfPeopleCommuting: Double? = nil // Special case handling, calculating average commute time
        
        ////////////////////////////// CITIES IN COUNTY LEVEL CASE //////////////////////////////
        if let countyCode = countyCode, let stateCode = stateCode {
            
            self.fetchEntity(countyCode: countyCode, stateCode: stateCode, completion: { county, state, us in
                
                guard let county = county else {
                    print("Error county for found!")
                    completion(false)
                    return
                }
                
                if county.loaded {
                    print("County info already loaded")
                    completion(true)
                    return
                }
                
                var tmpDataSetsInfo: [TmpDataSet] = []
                let template = data[0]
                
                for (index, valueName) in template.enumerate() {
                    if valueName.containsString("_001E") {
                        let dataSetCode = valueName.componentsSeparatedByString("_001E")[0]
                        
                        if let dataSetProperties = CensusAPIProperties.propertyTypesDictionary[type]![dataSetCode] {
                            
                            let tmpDataSet = TmpDataSet()
                            tmpDataSet.index = index
                            tmpDataSet.name = dataSetProperties[Hints.description]!
                            tmpDataSet.type = dataSetProperties[Hints.type]!
                            tmpDataSet.code = dataSetCode
                            tmpDataSet.dataSet = dataSetProperties
                            
                            for (innerLoopIndex, innerLoopValueName) in template.enumerate() {
                                if innerLoopValueName.containsString(dataSetCode) {
                                    tmpDataSet.valueIndexes.append(innerLoopIndex)
                                }
                            }
                            
                            tmpDataSetsInfo.append(tmpDataSet)
                            
                        } else {
                            print("Error - corresponding data set not found!") ////////////////////////////////////////
                            completion(false)
                            return
                        }
                    }
                }
                
                for values in data.dropFirst() {
                    
                    let city = NSEntityDescription.insertNewObjectForEntityForName(Hints.city, inManagedObjectContext: self.managedObjectContext) as! City
                    city.county = county
                    city.state = state
                    city.code = values[values.count - 1]
                    city.name = values[0].componentsSeparatedByString(", ")[0]
                    
                    
                    for tmpDataSet in tmpDataSetsInfo {
                        
                        let dataSet = NSEntityDescription.insertNewObjectForEntityForName(Hints.dataSet, inManagedObjectContext: self.managedObjectContext) as! DataSet
                        dataSet.code = tmpDataSet.code
                        dataSet.type = tmpDataSet.type
                        dataSet.name = tmpDataSet.name
                        dataSet.city = city
                        dataSet.total = values[tmpDataSet.index]
                        
                        // SPECIAL CASE HANDLING, CALCULATING AVERAGE COMMUTE TIME
                        if type == Hints.eduAndTrans {
                            if dataSet.code == "B08136" { totalCommuteTime = Double(dataSet.total!) }
                            else if dataSet.code == "B08301" { totalNumberOfPeopleCommuting = Double(dataSet.total!) }
                        }
                        
                        for valueSetIndex in tmpDataSet.valueIndexes {
                            
                            let dataSetValues = NSEntityDescription.insertNewObjectForEntityForName(Hints.dataSetValues, inManagedObjectContext: self.managedObjectContext) as! DataSetValues
                            dataSetValues.dataSet = dataSet
                            dataSetValues.code = template[valueSetIndex].componentsSeparatedByString("\(dataSet.code!)_")[1]
                            dataSetValues.name = tmpDataSet.dataSet[dataSetValues.code!]
                            dataSetValues.absoluteValue = values[valueSetIndex]
                            dataSetValues.percentValue = self.calculatePercentValue(dataSetValues.absoluteValue, total: dataSet.total)
                            
                            dataSet.values?.insert(dataSetValues)
                            
                        }
                        
                        city.dataSets?.insert(dataSet)
                        
                    }
                    
                    // SPECIAL CASE HANDLING, CALCULATING AVERAGE COMMUTE TIME
                    if type == Hints.eduAndTrans {
                        if let totalCommuteTime = totalCommuteTime, let totalNumberOfPeopleCommuting = totalNumberOfPeopleCommuting {
                            let averageTime = totalCommuteTime / totalNumberOfPeopleCommuting
                            let roundedAverageTime = Double(round(10 * averageTime) / 10)
                            let averageTimeString = "\(roundedAverageTime)%"
                            
                            for set in city.dataSets! {
                                if set.code == "B08136" {
                                    set.total = averageTimeString
                                    for value in set.values! {
                                        if value.code == "001E" {
                                            value.absoluteValue = averageTimeString
                                            value.percentValue = "100%"
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print("Error inserting county: \(error)") //////////////////////////
                        completion(false)
                        return
                    }
                }
                
                county.loaded = true
                print("Setting county to loaded") ////////////////////////////////////////////
                
                do {
                    try county.managedObjectContext!.save()
                    completion(true)
                } catch {
                    print("Error setting county status to loaded: \(error)") ////////////////////
                    completion(false)
                    return
                }
                
            })
            
            ////////////////////////////// COUNTIES IN STATE LEVEL CASE //////////////////////////////
        } else if let stateCode = stateCode {
            
            self.fetchEntity(countyCode: nil, stateCode: stateCode, completion: { county, state, us in
                
                guard let state = state else {
                    print("Error state for found!")
                    completion(false)
                    return
                }
                
                if state.loaded {
                    print("State counties info already loaded")
                    completion(true)
                    return
                }
                
                var tmpDataSetsInfo: [TmpDataSet] = []
                let template = data[0]
                
                for (index, valueName) in template.enumerate() {
                    if valueName.containsString("_001E") {
                        let dataSetCode = valueName.componentsSeparatedByString("_001E")[0]
                        
                        if let dataSetProperties = CensusAPIProperties.propertyTypesDictionary[type]![dataSetCode] {
                            
                            let tmpDataSet = TmpDataSet()
                            tmpDataSet.index = index
                            tmpDataSet.name = dataSetProperties[Hints.description]!
                            tmpDataSet.type = dataSetProperties[Hints.type]!
                            tmpDataSet.code = dataSetCode
                            tmpDataSet.dataSet = dataSetProperties
                            
                            for (innerLoopIndex, innerLoopValueName) in template.enumerate() {
                                if innerLoopValueName.containsString(dataSetCode) {
                                    tmpDataSet.valueIndexes.append(innerLoopIndex)
                                }
                            }
                            
                            tmpDataSetsInfo.append(tmpDataSet)
                            
                        } else {
                            print("Error - corresponding data set not found!") ////////////////////////////////////////
                            completion(false)
                            return
                        }
                    }
                }
                
                for values in data.dropFirst() {
                    
                    var fetchedCounty: County? = nil
                    
                    let countyName = values[0].componentsSeparatedByString(", ")[0]
                    let countyFetchRequest = NSFetchRequest(entityName: Hints.county)
                    let countyPredicate = NSPredicate(format: "%K == %@ && %K CONTAINS %@", Hints.stateCode, stateCode, Hints.name, countyName)
                    countyFetchRequest.predicate = countyPredicate
                    
                    do {
                        let countyResult = try self.managedObjectContext.executeFetchRequest(countyFetchRequest) as! [County]
                        if countyResult.isEmpty {
                            print("Error fetching county, search produced 0 results!") /////////////////////////////
                            completion(false)
                            return
                        } else {
                            fetchedCounty = countyResult[0]
                        }
                    } catch {
                        let fetchError = error as NSError
                        print("Error fetching county: \(fetchError.localizedDescription)") /////////////// HANDLE
                    }
                    
                    guard let currentCounty = fetchedCounty else {
                        print("Some weird error with county in counties in state") ////////////////////////////////
                        completion(false)
                        return
                    }
                    
            
                    for tmpDataSet in tmpDataSetsInfo {
                        
                        let dataSet = NSEntityDescription.insertNewObjectForEntityForName(Hints.dataSet, inManagedObjectContext: self.managedObjectContext) as! DataSet
                        dataSet.code = tmpDataSet.code
                        dataSet.type = tmpDataSet.type
                        dataSet.name = tmpDataSet.name
                        dataSet.county = currentCounty
                        dataSet.total = values[tmpDataSet.index]
                        
                        // SPECIAL CASE HANDLING, CALCULATING AVERAGE COMMUTE TIME
                        if type == Hints.eduAndTrans {
                            if dataSet.code == "B08136" { totalCommuteTime = Double(dataSet.total!) }
                            else if dataSet.code == "B08301" { totalNumberOfPeopleCommuting = Double(dataSet.total!) }
                        }
                        
                        for valueSetIndex in tmpDataSet.valueIndexes {
                            
                            let dataSetValues = NSEntityDescription.insertNewObjectForEntityForName(Hints.dataSetValues, inManagedObjectContext: self.managedObjectContext) as! DataSetValues
                            dataSetValues.dataSet = dataSet
                            dataSetValues.code = template[valueSetIndex].componentsSeparatedByString("\(dataSet.code!)_")[1]
                            dataSetValues.name = tmpDataSet.dataSet[dataSetValues.code!]
                            dataSetValues.absoluteValue = values[valueSetIndex]
                            dataSetValues.percentValue = self.calculatePercentValue(dataSetValues.absoluteValue, total: dataSet.total)
                            
                            dataSet.values?.insert(dataSetValues)
                            
                        }
                        
                        currentCounty.dataSets?.insert(dataSet)
                        
                    }
                    
                    // SPECIAL CASE HANDLING, CALCULATING AVERAGE COMMUTE TIME
                    if type == Hints.eduAndTrans {
                        if let totalCommuteTime = totalCommuteTime, let totalNumberOfPeopleCommuting = totalNumberOfPeopleCommuting {
                            let averageTime = totalCommuteTime / totalNumberOfPeopleCommuting
                            let roundedAverageTime = Double(round(10 * averageTime) / 10)
                            let averageTimeString = "\(roundedAverageTime)%"
                            
                            for set in currentCounty.dataSets! {
                                if set.code == "B08136" {
                                    set.total = averageTimeString
                                    for value in set.values! {
                                        if value.code == "001E" {
                                            value.absoluteValue = averageTimeString
                                            value.percentValue = "100%"
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print("Error inserting county: \(error)") //////////////////////////
                        completion(false)
                        return
                    }
                }
                
                state.loaded = true
                print("Setting state to loaded") ////////////////////////////////////////////
                
                do {
                    try state.managedObjectContext!.save()
                    completion(true)
                } catch {
                    print("Error setting state status to loaded: \(error)") ////////////////////
                    completion(false)
                    return
                }
                
            })
            
            ////////////////////////////// US LEVEL CASE //////////////////////////////
        } else {
            
            self.fetchEntity(countyCode: nil, stateCode: nil, completion: { county, state, us in
                
                guard let us = us else {
                    print("Error US for found!")
                    completion(false)
                    return
                }
                
                if us.loaded {
                    print("US info already loaded")
                    completion(true)
                    return
                }
                
                var tmpDataSetsInfo: [TmpDataSet] = []
                let template = data[0]
                
                for (index, valueName) in template.enumerate() {
                    if valueName.containsString("_001E") {
                        let dataSetCode = valueName.componentsSeparatedByString("_001E")[0]
                        
                        if let dataSetProperties = CensusAPIProperties.propertyTypesDictionary[type]![dataSetCode] {
                            
                            let tmpDataSet = TmpDataSet()
                            tmpDataSet.index = index
                            tmpDataSet.name = dataSetProperties[Hints.description]!
                            tmpDataSet.type = dataSetProperties[Hints.type]!
                            tmpDataSet.code = dataSetCode
                            tmpDataSet.dataSet = dataSetProperties
                            
                            for (innerLoopIndex, innerLoopValueName) in template.enumerate() {
                                if innerLoopValueName.containsString(dataSetCode) {
                                    tmpDataSet.valueIndexes.append(innerLoopIndex)
                                }
                            }
                            
                            tmpDataSetsInfo.append(tmpDataSet)
                            
                        } else {
                            print("Error - corresponding data set not found!") ////////////////////////////////////////
                            completion(false)
                            return
                        }
                    }
                }
                
                for values in data.dropFirst() {
                    
                    us.loaded = true
                    
                    for tmpDataSet in tmpDataSetsInfo {
                        
                        let dataSet = NSEntityDescription.insertNewObjectForEntityForName(Hints.dataSet, inManagedObjectContext: self.managedObjectContext) as! DataSet
                        dataSet.code = tmpDataSet.code
                        dataSet.type = tmpDataSet.type
                        dataSet.name = tmpDataSet.name
                        dataSet.us = us
                        dataSet.total = values[tmpDataSet.index]
                        
                        // SPECIAL CASE HANDLING, CALCULATING AVERAGE COMMUTE TIME
                        if type == Hints.eduAndTrans {
                            if dataSet.code == "B08136" { totalCommuteTime = Double(dataSet.total!) }
                            else if dataSet.code == "B08301" { totalNumberOfPeopleCommuting = Double(dataSet.total!) }
                        }
                        
                        for valueSetIndex in tmpDataSet.valueIndexes {
                            
                            let dataSetValues = NSEntityDescription.insertNewObjectForEntityForName(Hints.dataSetValues, inManagedObjectContext: self.managedObjectContext) as! DataSetValues
                            dataSetValues.dataSet = dataSet
                            dataSetValues.code = template[valueSetIndex].componentsSeparatedByString("\(dataSet.code!)_")[1]
                            dataSetValues.name = tmpDataSet.dataSet[dataSetValues.code!]
                            dataSetValues.absoluteValue = values[valueSetIndex]
                            dataSetValues.percentValue = self.calculatePercentValue(dataSetValues.absoluteValue, total: dataSet.total)
                            
                            dataSet.values?.insert(dataSetValues)
                            
                        }
                        
                        us.dataSets?.insert(dataSet)
                        
                    }
                    
                    // SPECIAL CASE HANDLING, CALCULATING AVERAGE COMMUTE TIME
                    if type == Hints.eduAndTrans {
                        if let totalCommuteTime = totalCommuteTime, let totalNumberOfPeopleCommuting = totalNumberOfPeopleCommuting {
                            let averageTime = totalCommuteTime / totalNumberOfPeopleCommuting
                            let roundedAverageTime = Double(round(10 * averageTime) / 10)
                            let averageTimeString = "\(roundedAverageTime)%"
                            
                            for set in us.dataSets! {
                                if set.code == "B08136" {
                                    set.total = averageTimeString
                                    for value in set.values! {
                                        if value.code == "001E" {
                                            value.absoluteValue = averageTimeString
                                            value.percentValue = "100%"
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    do {
                        try self.managedObjectContext.save()
                        
                    } catch {
                        print("Error inserting county: \(error)") //////////////////////////
                        completion(false)
                        return
                    }
                }
                
                completion(true)
                
            })
        }
    }
    
    
    func fetchEntity(countyCode countyCode: String?, stateCode: String?, completion:(county: County?, state: State?, us: US?) -> Void) {
        
        var us: US? = nil
        var state: State? = nil
        var county: County? = nil
        
        
        let usFetchRequest = NSFetchRequest(entityName: Hints.us)
        let usPredicate = NSPredicate(value: true)
        usFetchRequest.predicate = usPredicate
        
        do {
            let usResult = try self.managedObjectContext.executeFetchRequest(usFetchRequest) as! [US]
            us = usResult[0]
        } catch {
            let fetchError = error as NSError
            print("Error fetching us: \(fetchError.localizedDescription)") /////////////// HANDLE
        }
        
        if let stateCode = stateCode {
            
            let stateFetchRequest = NSFetchRequest(entityName: Hints.state)
            let statePredicate = NSPredicate(format: "%K == %@", Hints.code, stateCode)
            stateFetchRequest.predicate = statePredicate
            
            do {
                let stateResult = try self.managedObjectContext.executeFetchRequest(stateFetchRequest) as! [State]
                state = stateResult[0]
            } catch {
                let fetchError = error as NSError
                print("Error fetching state: \(fetchError.localizedDescription)") /////////////// HANDLE
            }
        }
        
        if let countyCode = countyCode, let state = state {
            
            let countyFetchRequest = NSFetchRequest(entityName: Hints.county)
            let countyPredicate = NSPredicate(format: "%K == %@ && %K CONTAINS %@",Hints.stateLowercase, state, Hints.code, countyCode)
            countyFetchRequest.predicate = countyPredicate
            
            do {
                let countyResult = try self.managedObjectContext.executeFetchRequest(countyFetchRequest) as! [County]
                county = countyResult[0]
            } catch {
                let fetchError = error as NSError
                print("Error fetching county: \(fetchError.localizedDescription)") /////////////// HANDLE
            }
        }
        completion(county: county, state: state, us: us)
    }
    
    
    func loadCodes(countyName countyName: String?, stateAbbreviation: String, completion:(countyCode: String?, stateCode: String?, error: ErrorType?) -> Void) {
        
        let stateFetchRequest = NSFetchRequest(entityName: Hints.state)
        let statePredicate = NSPredicate(format: "%K == %@", Hints.abbreviation, stateAbbreviation)
        stateFetchRequest.predicate = statePredicate
        
        do {
            
            let stateResult = try self.managedObjectContext.executeFetchRequest(stateFetchRequest) as! [State]
            if stateResult.isEmpty {
                print("Error - state not found!")
                completion(countyCode: nil, stateCode: nil, error: nil)
                
            } else {
                
                let state = stateResult[0]
                
                if let countyName = countyName {
                    
                    let countyFetchRequest = NSFetchRequest(entityName: Hints.county)
                    let countyPredicate = NSPredicate(format: "%K == %@ && %K CONTAINS %@",Hints.stateLowercase, state, Hints.name, countyName)
                    countyFetchRequest.predicate = countyPredicate
                    
                    do {
                        
                        let countyResult = try self.managedObjectContext.executeFetchRequest(countyFetchRequest) as! [County]
                        if countyResult.isEmpty {
                            print("Error - county not found!")
                            completion(countyCode: nil, stateCode: nil, error: nil)
                            
                        } else {
                            
                            let county = countyResult[0]
                            
                            let stateCode = state.code
                            let countyCode = county.code
                            
                            completion(countyCode: countyCode, stateCode: stateCode, error: nil)
                        }
                        
                    } catch {
                        let fetchError = error as NSError
                        print("Error fetching county: \(fetchError.localizedDescription)") /////////////// HANDLE
                        completion(countyCode: nil, stateCode: nil, error: fetchError)
                    }
                    
                } else {
                    
                    completion(countyCode: nil, stateCode: state.code, error: nil)
                    
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print("Error fetching state: \(fetchError.localizedDescription)") /////////////// HANDLE
            completion(countyCode: nil, stateCode: nil, error: fetchError)
        }
    }
    
    
    private func calculatePercentValue(part: String?, total: String?) -> String {
        
        if let part = part, let total = total {
            if let partDouble = Double(part), let totalDouble = Double(total) {
                let percent = partDouble / totalDouble * 100
                let rounded = Double(round(10 * percent) / 10)
                return "\(rounded)%"
            }
        }
        //print("Error - cannot calculate Percent Value")
        return "N/A"
    }
    
    
}



private class TmpDataSet {
    var type: String = ""
    var name: String = ""
    var code: String = ""
    var dataSet: [String: String] = [:]
    var index: Int = 0
    var valueIndexes: [Int] = []
}