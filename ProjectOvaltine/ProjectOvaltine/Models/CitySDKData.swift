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
    
    var walkingCommuteTime: Int //(Normalizable) Time spent commuting (in minutes): walking.
    let age: String //Median age.
    let incomePerCapita: Int //Per capita income in the past 12 months (in 2013 inflation-adjusted dollars).
    let poverty: Int //Number of persons whose income in the past 12 months is below the poverty level.
    let highSchoolEducation: Int //The number of persons age 25 and over who have a regular high school diploma.
    let medianRent: Int //Median contract rent
    let locationName: String
    let latitude: String
    let longitude: String
    let laborForceParticipation: Int //Number of persons, age 16 or older, in the labor force.
    let laborForceEmployment: Int //Number of employed, age 16 or older, in the civilian labor force.
    
    init(json:JSON) {
        self.walkingCommuteTime = json["B08136_011E"].int!
        self.age = json["B01002_001E"].string!
        self.incomePerCapita = json["B19301_001E"].int!
        self.poverty = json["B17001_002E"].int!
        self.highSchoolEducation = json["B15003_017E"].int!
        self.medianRent = json["B25058_001E"].int!
        self.locationName = json["NAME"].string!
        self.latitude = json["INTPTLAT"].string!
        self.longitude = json["INTPTLON"].string!
        self.laborForceParticipation = json["B23025_002E"].int!
        self.laborForceEmployment = json["B23025_004E"].int!
    }
}