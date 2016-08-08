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
            commuteWalk = json["B08136_011E"].string,
            medianAge = json["B01002_001E"].string,
            perCapitaIncome = json["B19301_001E"].string,
            povertyStats = json["B17001_002E"].string,
            highschoolEdu = json["B15003_017E"].string,
            medRents = json["B25058_001E"].string,
            localName = json["NAME"].string,
            lat = json["INTPTLAT"].string,
            lng = json["INTPTLON"].string,
            laborParticipation = json["B23025_002E"].string
            else {
                fatalError("Fuck haaris")
            }
        
        self.walkingCommuteTime = commuteWalk
        self.age = medianAge
        self.incomePerCapita = perCapitaIncome
        self.poverty = povertyStats
        self.highSchoolEducation = highschoolEdu
        self.medianRent = medRents
        self.locationName = localName
        self.latitude = lat
        self.longitude = lng
        self.laborForceParticipation = laborParticipation
    }
}