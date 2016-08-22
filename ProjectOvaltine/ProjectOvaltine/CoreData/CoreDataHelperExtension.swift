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
    
    func processData(data: [[String]], level: String, stateCode: String?, type: String, completion:(Bool) -> Void) {
        
        var totalCommuteTime: Double? = nil // Special case handling, calculating average commute time
        var totalNumberOfPeopleCommuting: Double? = nil // Special case handling, calculating average commute time
        
        switch level {
            
        ////////////////////////////// CITIES IN A STATE LEVEL CASE //////////////////////////////
        case Hints.city:
            
            self.fetchState(stateCode: stateCode!, completion: { state in
                print("INSIDE FETCH STATE FOR CITY COMPLETION BLOCK, state code: \(stateCode), state fetched: \(state?.abbreviation)") /////////////////
                
                guard let state = state else {
                    print("Error state for found!")
                    completion(false)
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
                    
                    let cityName = values[0].componentsSeparatedByString(", ")[0]
                    
                    var city = CensusAPIClient().findCity(cityName: cityName, inState: state)
                    
                    if city == nil {
                        let cityCode = values[values.count - 1]
                        city = NSEntityDescription.insertNewObjectForEntityForName(Hints.city, inManagedObjectContext: self.managedObjectContext) as? City
                        city!.name = cityName
                        city!.code = cityCode
                        city!.state = state
                    }
                    
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
                        
                        city!.dataSets?.insert(dataSet)
                        
                    }
                    
                    // SPECIAL CASE HANDLING, CALCULATING AVERAGE COMMUTE TIME
                    if type == Hints.eduAndTrans {
                        if let totalCommuteTime = totalCommuteTime, let totalNumberOfPeopleCommuting = totalNumberOfPeopleCommuting {
                            let averageTime = totalCommuteTime / totalNumberOfPeopleCommuting
                            let roundedAverageTime = Double(round(10 * averageTime) / 10)
                            let averageTimeString = "\(roundedAverageTime)%"
                            
                            for set in city!.dataSets! {
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
                        print("Error inserting city: \(error)") //////////////////////////
                        completion(false)
                        return
                    }
                }
            })
            
            
        ////////////////////////////// COUNTIES IN A STATE LEVEL CASE //////////////////////////////
        case Hints.county:
            
            self.fetchState(stateCode: stateCode!, completion: { state in
                
                guard let state = state else {
                    print("Error state for found!")
                    completion(false)
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
                    
                    let countyName = values[0].componentsSeparatedByString(", ")[0]
                    
                    var county = CensusAPIClient().findCounty(countyName: countyName, inState: state)
                    
                    if county == nil {
                        let countyCode = values[values.count - 1]
                        county = NSEntityDescription.insertNewObjectForEntityForName(Hints.county, inManagedObjectContext: self.managedObjectContext) as? County
                        county!.name = countyName
                        county!.code = countyCode
                        county!.state = state
                    }
                    
                    for tmpDataSet in tmpDataSetsInfo {
                        
                        let dataSet = NSEntityDescription.insertNewObjectForEntityForName(Hints.dataSet, inManagedObjectContext: self.managedObjectContext) as! DataSet
                        dataSet.code = tmpDataSet.code
                        dataSet.type = tmpDataSet.type
                        dataSet.name = tmpDataSet.name
                        dataSet.county = county
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
                        
                        county!.dataSets?.insert(dataSet)
                        
                    }
                    
                    // SPECIAL CASE HANDLING, CALCULATING AVERAGE COMMUTE TIME
                    if type == Hints.eduAndTrans {
                        if let totalCommuteTime = totalCommuteTime, let totalNumberOfPeopleCommuting = totalNumberOfPeopleCommuting {
                            let averageTime = totalCommuteTime / totalNumberOfPeopleCommuting
                            let roundedAverageTime = Double(round(10 * averageTime) / 10)
                            let averageTimeString = "\(roundedAverageTime)%"
                            
                            for set in county!.dataSets! {
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
            })
            
        ////////////////////////////// STATES IN US LEVEL CASE //////////////////////////////
        case Hints.state:
            
            self.fetchUS({ us in
                
                guard let us = us else {
                    print("Error US for found!")
                    completion(false)
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
                    
                    var state: State? = nil
                    let stateCode = values[values.count - 1]
                    
                    self.fetchState(stateCode: stateCode, completion: { fetchedState in
                        
                        if fetchedState != nil {
                            state = fetchedState
                        } else {
                            state = NSEntityDescription.insertNewObjectForEntityForName(Hints.state, inManagedObjectContext: self.managedObjectContext) as? State
                            let stateName = values[0].componentsSeparatedByString(", ")[0]
                            state!.name = stateName
                            state!.code = stateCode
                            state!.abbreviation = StateCodes.stateCodesDictionary.allKeysForValue(stateCode)[0]
                            state!.us = us
                        }
                        
                        for tmpDataSet in tmpDataSetsInfo {
                            
                            let dataSet = NSEntityDescription.insertNewObjectForEntityForName(Hints.dataSet, inManagedObjectContext: self.managedObjectContext) as! DataSet
                            dataSet.code = tmpDataSet.code
                            dataSet.type = tmpDataSet.type
                            dataSet.name = tmpDataSet.name
                            dataSet.state = state
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
                            
                            state!.dataSets?.insert(dataSet)
                            
                        }
                        
                        // SPECIAL CASE HANDLING, CALCULATING AVERAGE COMMUTE TIME
                        if type == Hints.eduAndTrans {
                            if let totalCommuteTime = totalCommuteTime, let totalNumberOfPeopleCommuting = totalNumberOfPeopleCommuting {
                                let averageTime = totalCommuteTime / totalNumberOfPeopleCommuting
                                let roundedAverageTime = Double(round(10 * averageTime) / 10)
                                let averageTimeString = "\(roundedAverageTime)%"
                                
                                for set in state!.dataSets! {
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
                            print("Error inserting state: \(error)") //////////////////////////
                            completion(false)
                            return
                        }
                    })
                }
            })
            
            
        ////////////////////////////// US LEVEL CASE //////////////////////////////
        case Hints.us:
            print("PROCESSING US DATA OF TYPE: \(type)") /////////////////////////////////////////////////////////
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
                
                var us: US? = nil
                
                
                self.fetchUS { fetchedUS in
                    
                    if fetchedUS != nil {
                        us = fetchedUS
                    } else {
                        us = NSEntityDescription.insertNewObjectForEntityForName(Hints.us, inManagedObjectContext: self.managedObjectContext) as? US
                        let usName = values[0].componentsSeparatedByString(", ")[0]
                        us!.name = usName
                        
                    }
                    
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
                        
                        us!.dataSets?.insert(dataSet)
                        
                    }
                    
                    // SPECIAL CASE HANDLING, CALCULATING AVERAGE COMMUTE TIME
                    if type == Hints.eduAndTrans {
                        if let totalCommuteTime = totalCommuteTime, let totalNumberOfPeopleCommuting = totalNumberOfPeopleCommuting {
                            let averageTime = totalCommuteTime / totalNumberOfPeopleCommuting
                            let roundedAverageTime = Double(round(10 * averageTime) / 10)
                            let averageTimeString = "\(roundedAverageTime)%"
                            
                            for set in us!.dataSets! {
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
                        print("Error inserting state: \(error)") //////////////////////////
                        completion(false)
                        return
                    }
                }
            }
            
            
        default:
            print("Error - invalid level!")
            completion(false)
            return
        }
        
        completion(true)
        
    }
    
    
    func fetchState(stateCode stateCode: String, completion:(state: State?) -> Void) {
        let fetchRequest = NSFetchRequest(entityName: Hints.state)
        let predicate = NSPredicate(format: "%K == %@", Hints.code, stateCode)
        fetchRequest.predicate = predicate
        
        do {
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [State]
            if !result.isEmpty {
                completion(state: result[0])
            } else {
                completion(state: nil)
            }
        } catch {
            let fetchError = error as NSError
            print("Error fetching state: \(fetchError.localizedDescription)") /////////////// HANDLE
            completion(state: nil)
        }
    }
    
    
    func fetchUS(completion:(us: US?) -> Void) {
        let fetchRequest = NSFetchRequest(entityName: Hints.us)
        let predicate = NSPredicate(value: true)
        fetchRequest.predicate = predicate
        
        do {
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [US]
            if !result.isEmpty {
                completion(us: result[0])
            } else {
                completion(us: nil)
            }
        } catch {
            let fetchError = error as NSError
            print("Error fetching us: \(fetchError.localizedDescription)") /////////////// HANDLE
            completion(us: nil)
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
    
    
    func clearCoreData() { // DELETE IN THE PRODUCTION VERSION, FUNCTION EXISTS FOR TESTING ONLY
        self.removeData("City")
        self.removeData("County") ////////////////////// REMOVE
        self.removeData("State") ////////////////////// REMOVE FOR PRODUCTION
        self.removeData("US") ////////////////////////// REMOVE
        self.removeData("DataSet")
        self.removeData("DataSetValues")
    }
    
    
    private func removeData(entity: String) { // DELETE IN THE PRODUCTION VERSION, FUNCTION EXISTS FOR TESTING ONLY
        print("Removing from CoreData: \(entity)")
        let managedObjectContext = self.managedObjectContext
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
    
    
}



private class TmpDataSet {
    var type: String = ""
    var name: String = ""
    var code: String = ""
    var dataSet: [String: String] = [:]
    var index: Int = 0
    var valueIndexes: [Int] = []
}


extension Dictionary where Value : Equatable {
    func allKeysForValue(val : Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}