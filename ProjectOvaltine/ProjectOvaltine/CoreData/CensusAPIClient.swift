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
        
        self.coreDataHelper.loadCodes(countyName: countyName, stateAbbreviation: stateAbbreviation) { (countyCode, stateCode, error) in
            if error != nil {
                print("Error performing data request for location")
                completion(city: nil, county: nil, state: nil, us: nil)
                return
            }
            if countyCode == nil {
                print("Unable to get county code")
            }
            if stateCode == nil {
                print("Unable to get state code")
            }
            
            self.coreDataHelper.fetchEntity(countyCode: countyCode, stateCode: stateCode, completion: { (countyOptional, stateOptional, us) in
                guard let county = countyOptional else {
                    print("Unable to fetch county")
                    completion(city: nil, county: countyOptional, state: stateOptional, us: us)
                    return
                }
                
                guard let state = stateOptional else {
                    print("Unable to fetch state")
                    completion(city: nil, county: countyOptional, state: stateOptional, us: us)
                    return
                }
                
                if us == nil {
                    print("Unable to fetch us. This is super weird! Have you parced codes?")
                }
                
                if county.loaded == CensusAPIProperties.propertyTypesDictionary.count {
                    let city = self.findCity(cityName: cityName, inCounty: county)
                    print("Data available in CoreData, Census.gov API request not performed")
                    completion(city: city, county: county, state: state, us: us)
                } else {
                    print(county.code!) ///////////////////////////////////////////////////////
                    print(state.code!) ///////////////////////////////////////////////////////
                    print("Data not available in CoreData, performing Census.gov API request")
                    self.censusAPIrequest(countyCode: county.code!, stateCode: state.code!, completion: { (success) in
                        if success {
                            self.requestDataForLocation(placemark: placemark, completion: { (city, county, state, us) in
                                completion(city: city, county: county, state: state, us: us)
                            })
                        }
                    })
                }
            })
        }
    }
    
    
    private func findCity(cityName cityName: String, inCounty: County) -> City? {
        // print("Inside FIND CITY")
        // print("City Name: \(cityName)")
        //print("In County: \(inCounty.name!)")
        if let cities = inCounty.cities {
            for city in cities {
                if let name = city.name {
                    print(name)
                    if self.actualName(name) == self.actualName(cityName) {
                        return city
                    }
                }
            }
        }
        print("City < \(cityName) > not found in county < \(inCounty.name!) > ")
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
            
            requestForType(countyCode: countyCode, stateCode: stateCode, type: type) { data, error in
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
            
            requestForType(countyCode: nil, stateCode: stateCode, type: type) { data, error in
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
            
            requestForType(countyCode: nil, stateCode: nil, type: type) { data, error in
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
    
    
    private func requestForType(countyCode countyCode: String?, stateCode: String?, type: String, completion: ([[String]]?, NSError?) -> Void) {
        
        var url = NSURL(string: "")!
        
        if let countyCode = countyCode, let stateCode = stateCode {
            url = NSURL(string: "http://api.census.gov/data/2014/acs5?get=NAME,\(self.constructAPIRequestCodes(type))&for=county+subdivision:*&in=state:\(stateCode)+county:\(countyCode)&key=\(key)")!
            
        } else if let stateCode = stateCode {
            url = NSURL(string: "http://api.census.gov/data/2014/acs5?get=NAME,\(self.constructAPIRequestCodes(type))&for=county:*&in=state:\(stateCode)&key=\(key)")!
            
        } else {
            url = NSURL(string: "http://api.census.gov/data/2014/acs5?get=NAME,\(self.constructAPIRequestCodes(type))&for=us:*&key=\(key)")!
            
        }
        
        let request = NSMutableURLRequest(URL: url)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            if let error = error {
                print("Error getting data: \(error.localizedDescription)") ////////////////// Handle
                completion(nil, error)
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
                    completion(resultsAsArrays, nil)
                    
                } catch {
                    print("Error parcing JSON\n") ////////////// Handle
                    print(response) /////////////////////////////////
                    completion(nil, error as NSError)
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

