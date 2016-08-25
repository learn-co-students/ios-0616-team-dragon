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
        var usOptional: US? = nil
        var stateOptional: State? = nil
        
//        let address = placemark.addressDictionary!["FormattedAddressLines"] as! [String]
//        let cityName = address[0].componentsSeparatedByString(",")[0]
        
//        guard let cityName = placemark.locality else {
//            print("Error getting city name from placemark")
//            completion(city: nil, county: nil, state: nil, us: nil)
//            return
//        }
        
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
            usOptional = fetchedUS
            
            guard let us = usOptional else {
                print("Error getting us!")
                completion(city: nil, county: nil, state: nil, us: nil)
                return
            }
            
            self.getState(stateAbbreviation) { fetchedState in
                stateOptional = fetchedState

                guard let state = stateOptional else {
                    print("Error getting state")
                    completion(city: nil, county: nil, state: nil, us: us)
                    return
                }
                
                self.getCity(placemark, inState: state, completion: { city in
                    self.getCounty(countyName: countyName, inState: state, completion: { county in
                        completion(city: city, county: county, state: state, us: us)
                    })
                })
            }
        }
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
    
    
    private func getState(abbreviation: String, completion:(State?) -> Void) {
        guard let stateCode = StateCodes.stateCodesDictionary[abbreviation] else {
            print("Error - state code not found for state < \(abbreviation) >")
            completion(nil)
            return
        }
        
        self.coreDataHelper.fetchState(stateCode: stateCode) { fetchedState in
            if fetchedState != nil {
                completion(fetchedState)
            } else {
                self.getStateDataFromAPI(stateCode: stateCode) { success in
                    if success {
                        self.coreDataHelper.fetchState(stateCode: stateCode) { fetchedStateAfterAPICall in
                            completion(fetchedStateAfterAPICall)
                        }
                    } else {
                        completion(nil)
                    }
                }
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
                    self.coreDataHelper.processData(data, level: Hints.us, placemark: nil, stateCode: nil, type: type, completion: { success in
                        requestsToBeCompleted -= 1
                        if !success {
                            errors += 1
                            print("Error populating Core Data!")
                        }
                    })
                } else {
                    requestsToBeCompleted -= 1
                    errors += 1
                    print("Error processing API request")
                }
            })
        }
    }
    
    
    private func getStateDataFromAPI(stateCode stateCode: String, completion:(Bool) -> Void) {
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
                    self.coreDataHelper.processData(data, level: Hints.state, placemark: nil, stateCode: stateCode, type: type, completion: { success in
                        requestsToBeCompleted -= 1
                        if !success {
                            errors += 1
                            print("Error populating Core Data!")
                        }
                    })
                } else {
                    requestsToBeCompleted -= 1
                    errors += 1
                    print("Error processing API request")
                }
            })
        }
    }
    
    
    private func getCity(placemark: CLPlacemark, inState: State, completion:(City?) -> Void) {
        
        if let cities = inState.cities {
            if !cities.isEmpty {
                if let coreDataCity = self.findCity(placemark, inState: inState) {
                    completion(coreDataCity)
                } else {
                    self.getCityDataFromAPI(placemark, stateCode: inState.code!, completion: { success in
                        if success {
                            completion(self.findCity(placemark, inState: inState))
                        } else {
                            print("Error getting cities for state < \(inState.name!) > from the API")
                            completion(nil)
                        }
                    })
                }
            } else {
                self.getCityDataFromAPI(placemark, stateCode: inState.code!, completion: { success in
                    if success {
                        completion(self.findCity(placemark, inState: inState))
                    } else {
                        print("Error getting cities for state < \(inState.name!) > from the API")
                        completion(nil)
                    }
                })
            }
        } else {
            print("Weird error in Get City")
            completion(nil)
        }
    }
    
    
    private func getCityDataFromAPI(placemark: CLPlacemark,  stateCode: String, completion:(Bool) -> Void) {
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
            self.requestAPIData(level: Hints.city, stateCode: stateCode, type: type, completion: { data in
                if let data = data {
                    self.coreDataHelper.processData(data, level: Hints.city, placemark: placemark, stateCode: stateCode, type: type, completion: { success in
                        requestsToBeCompleted -= 1
                        if !success {
                            errors += 1
                            print("Error populating Core Data!")
                        }
                    })
                } else {
                    requestsToBeCompleted -= 1
                    errors += 1
                    print("Error processing API request")
                }
            })
        }
    }
    
    
    func findCity(placemark: CLPlacemark, inState: State) -> City? {
        let address = placemark.addressDictionary!["FormattedAddressLines"] as! [String]
        let cityNameFromAddress = address[0].componentsSeparatedByString(",")[0]
        
        guard let cityNameFromLocality = placemark.locality else {
            print("Error getting city name from placemark")
            return nil
        }
        
        if let cities = inState.cities {
            for city in cities {
                if let name = city.name {
                    if self.actualName(name) == self.actualName(cityNameFromAddress) {
                        return city
                    }
                }
            }
            for city in cities {
                if let name = city.name {
                    if self.actualName(name) == self.actualName(cityNameFromLocality) {
                        return city
                    }
                }
            }
            
        }
        return nil
    }
    
    
    private func getCounty(countyName countyName: String, inState: State, completion:(County?) -> Void) {
        if let counties = inState.counties {
            if !counties.isEmpty {
                completion(self.findCounty(countyName: countyName, inState: inState))
            } else {
                self.getCountyDataFromAPI(stateCode: inState.code!, completion: { success in
                    if success {
                        completion(self.findCounty(countyName: countyName, inState: inState))
                    } else {
                        print("Error getting cities for state < \(inState.name!) > from the API")
                        completion(nil)
                    }
                })
            }
        } else {
            print("Weird error in Get County")
            completion(nil)
        }
    }
    
    
    private func getCountyDataFromAPI(stateCode stateCode: String, completion:(Bool) -> Void) {
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
            self.requestAPIData(level: Hints.county, stateCode: stateCode, type: type, completion: { data in
                if let data = data {
                    self.coreDataHelper.processData(data, level: Hints.county, placemark: nil, stateCode: stateCode, type: type, completion: { success in
                        requestsToBeCompleted -= 1
                        if !success {
                            errors += 1
                            print("Error populating Core Data!")
                        }
                    })
                } else {
                    requestsToBeCompleted -= 1
                    errors += 1
                    print("Error processing API request")
                }
            })
        }
    }
    
    
    func findCounty(countyName countyName: String, inState: State) -> County? {
        if let counties = inState.counties {
            for county in counties {
                if let name = county.name {
                    if self.actualName(name) == self.actualName(countyName) {
                        return county
                    }
                }
            }
        }
        return nil
    }
    
    
    func actualName(name: String) -> String {
        let wordsArray = name.componentsSeparatedByString(" ")
        let uppercaseWords = wordsArray.filter { (word) -> Bool in
            word == word.capitalizedString && word != word.uppercaseString && word != Hints.county
        }
        let actualName = uppercaseWords.joinWithSeparator(" ")
        return actualName
        
    }
    
    
    private func requestAPIData(level level: String, stateCode: String?, type: String, completion: ([[String]]?) -> Void) {
        
        var url = NSURL(string: "")!
        let urlStartString = "http://api.census.gov/data/2014/acs5?get=NAME,\(self.constructAPIRequestCodes(type))&for="
        
        switch level {
            
        case Hints.city:
            url = NSURL(string: "\(urlStartString)place:*&in=state:\(stateCode!)&key=\(key)")!
        case Hints.county:
            url = NSURL(string: "\(urlStartString)county:*&in=state:\(stateCode!)&key=\(key)")!
        case Hints.state:
            url = NSURL(string: "\(urlStartString)state:*&key=\(key)")!
        case Hints.us:
            url = NSURL(string: "\(urlStartString)us:*&key=\(key)")!
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
                    print("Error parcing JSON!\nResponse: \(response)") ////////////// Handle
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
                if code != Hints.type && code != Hints.description && code != Hints.ratable && code != Hints.displayPercent {
                    codesString += dataSet + "_" + code + ","
                }
            }
        }

        if codesString.characters.count > 0 { codesString = codesString.substringToIndex(codesString.endIndex.predecessor()) }
        return codesString
    }
    

}

