//
//  CitySDKData.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/7/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import SwiftyJSON

class CitySDKData {
    
<<<<<<< HEAD
    static let dataStore = citySDKData()
        
    func getDataWithCompletion(completion: () -> ()){}
    
=======
    var walkingCommuteTime: String //(Normalizable) Time spent commuting (in minutes): walking.
    var age: String //Median age.
    var incomePerCapita: String //Per capita income in the past 12 months (in 2013 inflation-adjusted dollars).
    var poverty: String //Number of persons whose income in the past 12 months is below the poverty level.
    var highSchoolEducation: String //The number of persons age 25 and over who have a regular high school diploma.
    var medianRent: String //Median contract rent
    var locationName: String
    var latitude: String
    var longitude: String
    var laborForceParticipation: String //Number of persons, age 16 or older, in the labor force.
    //var laborForceEmployment: String //Number of employed, age 16 or older, in the civilian labor force.
    
    init(json:JSON) {
        guard let
            walkTime = json["B08136_011E"].string,
            ageStuff = json["B01002_001E"].string,
            incomeStuff = json["B19301_001E"].string,
            povertyStuff = json["B17001_002E"].string,
            highSchool = json["B15003_017E"].string,
            medianRental = json["B25058_001E"].string,
            localStuff = json["NAME"].string,
            latnew = json["INTPTLAT"].string,
            longnew = json["INTPTLON"].string,
            partic = json["B23025_002E"].string
            //emple = json["B23025_004E"].string
            else {
                fatalError("Fuck haaris")
            }
        
        self.walkingCommuteTime = walkTime
        self.age = ageStuff
        self.incomePerCapita = incomeStuff
        self.poverty = povertyStuff
        self.highSchoolEducation = highSchool
        self.medianRent = medianRental
        self.locationName = localStuff
        self.latitude = latnew
        self.longitude = longnew
        //self.laborForceEmployment = emple
        self.laborForceParticipation = partic
    }
>>>>>>> master
}