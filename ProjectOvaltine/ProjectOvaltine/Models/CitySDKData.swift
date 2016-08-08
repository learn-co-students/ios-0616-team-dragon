//
//  CitySDKData.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/7/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import SwiftyJSON

class citySDKData {
    
    var walkingCommuteTime: Int //(Normalizable) Time spent commuting (in minutes): walking.
    var age: String //Median age.
    var incomePerCapita: Int //Per capita income in the past 12 months (in 2013 inflation-adjusted dollars).
    var poverty: Int //Number of persons whose income in the past 12 months is below the poverty level.
    var highSchoolEducation: Int //The number of persons age 25 and over who have a regular high school diploma.
    var medianRent: Int //Median contract rent
    var locationName: String
    var latitude: String
    var longitude: String
    var laborForceParticipation: Int //Number of persons, age 16 or older, in the labor force.
    var laborForceEmployment: Int //Number of employed, age 16 or older, in the civilian labor force.
    
    init(json:JSON) {
        guard let
            walkCommute = json["B08136_011E"].int,
            avgAge = json["B01002_001E"].string,
            avgIncome = json["B19301_001E"].int,
            avgPoverty = json["B17001_002E"].int,
            areaHighSchoolDegree = json["B15003_017E"].int,
            medianRentArea = json["B25058_001E"].int,
            localName = json["NAME"].string,
            lat = json["INTPTLAT"].string,
            lng = json["INTPTLON"].string,
            laborParticipation = json["B23025_002E"].int,
            laborEmployment = json["B23025_004E"].int
            else {
                print("Failed")
                return
        }
        
        self.walkingCommuteTime = walkCommute
        self.age = avgAge
        self.incomePerCapita = avgIncome
        self.poverty = avgPoverty
        self.highSchoolEducation = areaHighSchoolDegree
        self.medianRent = medianRentArea
        self.locationName = localName
        self.latitude = lat
        self.longitude = lng
        self.laborForceParticipation = laborParticipation
        self.laborForceEmployment = laborEmployment
    }
    
    
    
}