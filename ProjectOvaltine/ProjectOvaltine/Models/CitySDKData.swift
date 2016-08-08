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
    var walkingCommuteTime: Int
    var age: String
    var incomePerCapita: Int
    var poverty: Int
    var highSchoolEducation: Int
    var medianRent: Int
    var locationName: String
    var latitude: String
    var longitude: String
    
    init(json:JSON) {
        let walkCommute = json["B08136_011E"].int
        let avgAge = json["B01002_001E"].string
        let avgIncome = json["B19301_001E"].int
        let avgPoverty = json["B17001_002E"].int
        let areaHighSchoolDegree = json["B15003_017E"].int
        let medianRentArea = json["B25058_001E"].int
        let localName = json["NAME"].string
        let lat = json["INTPTLAT"].string
        let lng = json["INTPTLON"].string
        
        self.walkingCommuteTime = walkCommute!
        self.age = avgAge!
        self.incomePerCapita = avgIncome!
        self.poverty = avgPoverty!
        self.highSchoolEducation = areaHighSchoolDegree!
        self.medianRent = medianRentArea!
        self.locationName = localName!
        self.latitude = lat!
        self.longitude = lng!
    }
    
    
}