//
//  CensusAPIClient.swift
//  dataPopulation
//
//  Created by Max Tkach on 8/12/16.
//  Copyright © 2016 Anvil. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class CensusAPIClient {
    
    let coreDataHelper = CoreDataHelper()
    let key = Constants.CENSUS_API_KEY
    
    
    func requestDataForLocation(placemark placemark: CLPlacemark, completion:(city: City?, county: County?, state: State?, us: US?) -> Void) {
        
        var us: US? = nil
        var state: State? = nil
        var county: County? = nil
        var city: City? = nil
        
        guard let cityName = placemark.locality else {
            print("Error getting city name from placemark")
            completion(city: nil, county: nil, state: nil, us: nil)
            return
        }
        
        guard let countyName = placemark.subAdministrativeArea else {
            print("Error getting county name from placemark")
            completion(city: nil, county: nil, state: nil, us: nil)
            return
        }
        
        guard let stateAbbreviation = placemark.administrativeArea else {
            print("Error getting state name from placemark")
            completion(city: nil, county: nil, state: nil, us: nil)
            return
        }
        
        
        self.getUS { fetchedUS in
            if fetchedUS != nil {
                us = fetchedUS
            } else {
                print("Error - can't get US data")
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        self.coreDataHelper.loadCodes(countyName: countyName, stateAbbreviation: stateAbbreviation) { (countyCode, stateCode, error) in
//            if error != nil {
//                print("Error performing data request for location")
//                completion(city: nil, county: nil, state: nil, us: nil)
//                return
//            }
//            if countyCode == nil {
//                print("Unable to get county code")
//            }
//            if stateCode == nil {
//                print("Unable to get state code")
//            }
//            
//            self.coreDataHelper.fetchEntity(countyCode: countyCode, stateCode: stateCode, completion: { (countyOptional, stateOptional, us) in
//                guard let county = countyOptional else {
//                    print("Unable to fetch county")
//                    completion(city: nil, county: countyOptional, state: stateOptional, us: us)
//                    return
//                }
//                
//                guard let state = stateOptional else {
//                    print("Unable to fetch state")
//                    completion(city: nil, county: countyOptional, state: stateOptional, us: us)
//                    return
//                }
//                
//                if us == nil {
//                    print("Unable to fetch us. This is super weird! Have you parced codes?")
//                }
//                
//                if county.loaded == CensusAPIProperties.propertyTypesDictionary.count {
//                    let city = self.findCity(cityName: cityName, inState: state)
//                    print("Data available in CoreData, Census.gov API request not performed")
//                    completion(city: city, county: county, state: state, us: us)
//                } else {
//                    print(county.code!) ///////////////////////////////////////////////////////
//                    print(state.code!) ///////////////////////////////////////////////////////
//                    print("Data not available in CoreData, performing Census.gov API request")
//                    self.censusAPIrequest(countyCode: county.code!, stateCode: state.code!, completion: { (success) in
//                        if success {
//                            self.requestDataForLocation(placemark: placemark, completion: { (city, county, state, us) in
//                                completion(city: city, county: county, state: state, us: us)
//                            })
//                        }
//                    })
//                }
//            })
//        }
    }
    
    
    private func getUS(completion:(US?) -> Void) {
        
        self.coreDataHelper.fetchUS { fetchedUS in
            if fetchedUS != nil {
                completion(fetchedUS)
            } else {
                self.getUSDataFromAPI({ success in
                    if success {
                        self.coreDataHelper.fetchUS({ fetchedUSAfterAPICall in
                            completion(fetchedUSAfterAPICall)
                        })
                    } else {
                        completion(nil)
                    }
                })
            }
        }
    }
    
    
    private func getUSDataFromAPI(completion:(Bool) -> Void) {
        
        var errors = 0
        
        var requestsToBeCompleted = CensusAPIProperties.propertyTypesDictionary.keys.count {
            didSet {
                if requestsToBeCompleted == 0 {
                    if errors == 0 { completion(true) }
                    else { completion(false) }
                }
            }
        }
        
        for type in CensusAPIProperties.propertyTypesDictionary.keys {
            self.requestAPIData(level: Hints.us, stateCode: nil, type: type, completion: { data in
                if let data = data {
                    self.coreDataHelper.processData(data, level: Hints.us, stateCode: nil, type: type, completion: { success in
                        requestsToBeCompleted -= 1
                        if !success {
                            errors += 1
                            print("Error populating Core Data!")
                        }
                    })
                } else {
                    errors += 1
                    print("Error processing API request")
                }
            })
        }
        
    }
    
    
    private func getStateDataFromAPI(stateAbbreviation: String, completion:(Bool) -> Void) {
        
        guard let stateCode = StateCodes.stateCodesDictionary[stateAbbreviation] else {
            print("State not found!")
            completion(false)
            return
        }
        
        var errors = 0
        
        var requestsToBeCompleted = CensusAPIProperties.propertyTypesDictionary.keys.count {
            didSet {
                if requestsToBeCompleted == 0 {
                    if errors == 0 { completion(true) }
                    else { completion(false) }
                }
            }
        }
        
        for type in CensusAPIProperties.propertyTypesDictionary.keys {
            self.requestAPIData(level: Hints.state, stateCode: stateCode, type: type, completion: { data in
                if let data = data {
                    self.coreDataHelper.processData(data, level: Hints.state, stateCode: stateCode, type: type, completion: { success in
                        requestsToBeCompleted -= 1
                        if !success {
                            errors += 1
                            print("Error populating Core Data!")
                        }
                    })
                } else {
                    errors += 1
                    print("Error processing API request")
                }
            })
        }
        
    }
    
    
    private func findCity(cityName cityName: String, inState: State) -> City? {
        if let cities = inState.cities {
            for city in cities {
                if let name = city.name {
                    print(name)
                    if self.actualName(name) == self.actualName(cityName) {
                        return city
                    }
                }
            }
        }
        print("City < \(cityName) > not found in county < \(inState.name!) > ")
        return nil
    }
    
    
    private func findCounty(countyName countyName: String, inState: State) -> County? {
        if let counties = inState.counties {
            for county in counties {
                if let name = county.name {
                    print(name)
                    if self.actualName(name) == self.actualName(countyName) {
                        return county
                    }
                }
            }
        }
        print("County < \(countyName) > not found in county < \(inState.name!) > ")
        return nil
    }
    
    
    private func actualName(name: String) -> String {
        let wordsArray = name.componentsSeparatedByString(" ")
        let uppercaseWords = wordsArray.filter { (word) -> Bool in
            word == word.capitalizedString && word != word.uppercaseString
        }
        let actualName = uppercaseWords.joinWithSeparator(" ")
        return actualName
        
    }
    
    
    
    
    
    
    
    
    
    private func censusAPIrequest(countyCode countyCode: String, stateCode: String, completion: (Bool) -> Void) {
        
        var errors = false
        var requestsToBeCompleted = CensusAPIProperties.propertyTypesDictionary.keys.count * 3 /* levels count from below */ {
            didSet {
                if requestsToBeCompleted == 0 { completion(!errors) }
            }
        }
        
        
        // MAKES REQUESTS ON << 3 >> DIFFERENT LEVELS - all cities in the county for selected city, all counties for the state and US
        
        // NO STATE AVERAGES
        
        for type in CensusAPIProperties.propertyTypesDictionary.keys {
            
            requestForType(countyCode: countyCode, stateCode: stateCode, type: type) { data in
                if let data = data {
                    //print("We got city-county data!") ///////////////////////////////////////////////
                    self.coreDataHelper.processData(data, countyCode: countyCode, stateCode: stateCode, type: type, completion: { success in
                        requestsToBeCompleted -= 1
                        if !success {
                            errors = true
                            print("Error populating Core Data!")
                        }
                    })
                } else {
                    errors = true
                    print("Error processing API request")
                    requestsToBeCompleted -= 1
                }
            }
            
            requestForType(countyCode: nil, stateCode: stateCode, type: type) { data in
                if let data = data {
                    //print("We got county-state data!") ///////////////////////////////////////////////
                    self.coreDataHelper.processData(data, countyCode: nil, stateCode: stateCode, type: type, completion: { success in
                        requestsToBeCompleted -= 1
                        if !success {
                            errors = true
                            print("Error populating Core Data!")
                        }
                    })
                } else {
                    errors = true
                    print("Error processing API request")
                    requestsToBeCompleted -= 1
                }
            }
            
            requestForType(countyCode: nil, stateCode: nil, type: type) { data in
                if let data = data {
                    //print("We got US data!") ///////////////////////////////////////////////
                    self.coreDataHelper.processData(data, countyCode: nil, stateCode: nil, type: type, completion: { success in
                        requestsToBeCompleted -= 1
                        if !success {
                            errors = true
                            print("Error populating Core Data!")
                        }
                    })
                } else {
                    errors = true
                    print("Error processing API request")
                    requestsToBeCompleted -= 1
                }
            }
            
        }
    }
    
    
    private func requestAPIData(level level: String, stateCode: String?, type: String, completion: ([[String]]?) -> Void) {
        
        var url = NSURL(string: "")!
        
        switch level {
            
        case Hints.city:
            url = NSURL(string: "http://api.census.gov/data/2014/acs5?get=NAME,\(self.constructAPIRequestCodes(type))&for=place:*&in=state:\(stateCode)&key=\(key)")!
        case Hints.county:
            url = NSURL(string: "http://api.census.gov/data/2014/acs5?get=NAME,\(self.constructAPIRequestCodes(type))&for=county:*&in=state:\(stateCode)&key=\(key)")!
        case Hints.state:
            url = NSURL(string: "http://api.census.gov/data/2014/acs5?get=NAME,\(self.constructAPIRequestCodes(type))&for=state:*&key=\(key)")!
        case Hints.us:
            url = NSURL(string: "http://api.census.gov/data/2014/acs5?get=NAME,\(self.constructAPIRequestCodes(type))&for=us:*&key=\(key)")!
        
        default:
            print("ERROR - INVALID REQUEST LEVEL")
            completion(nil)
            return
        }
        
        let request = NSMutableURLRequest(URL: url)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            if let error = error {
                print("Error getting data: \(error.localizedDescription)") ////////////////// Handle
                completion(nil)
            }
            
            if let data = data {
                do {
                    let resultsArray = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSArray
                    var resultsAsArrays: [[String]] = []
                    for resultArray in resultsArray {
                        let resultAsNSArray = resultArray as! NSArray
                        var resultAsArray: [String] = []
                        for result in resultAsNSArray {
                            resultAsArray.append(String(result))
                        }
                        resultsAsArrays.append(resultAsArray)
                    }
                    //print("RESULT FOR:\nstate: \(stateCode) \ncounty: \(countyCode) \ntype: \(type) \nresult: \(resultsArray)\n") ///////////////////////////// REMOVE
                    completion(resultsAsArrays)
                    
                } catch {
                    print("Error parcing JSON\n") ////////////// Handle
                    print(response) /////////////////////////////////
                    completion(nil)
                    return
                }
            }
        }
        task.resume()
    }
    
    
    private func constructAPIRequestCodes(type: String) -> String {
        var codesString = ""
        
        guard let propertyType = CensusAPIProperties.propertyTypesDictionary[type] else {
            print("Error getting properties of type \(type)")
            return ""
        }
        
        for (dataSet, codes) in propertyType {
            for code in codes.keys {
                if code != Hints.type && code != Hints.description {
                    codesString += dataSet + "_" + code + ","
                }
            }
        }

        if codesString.characters.count > 0 { codesString = codesString.substringToIndex(codesString.endIndex.predecessor()) }
        return codesString
    }
    

}

