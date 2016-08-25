//
//  CitySDKDataStore.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import CoreLocation


class DataStore {
    static let sharedInstance = DataStore()
    
    let cityAPI = CitySDKAPIClient()
    
    var cityName : String?
    var countyName : String?
    
    var cityDataPoints:[CitySDKData] = []
    
    var comparisonData: ScoreModel?
    
    var comparisonPercentageData: ScoreModel?

    let levelOfLocationDetails = "county"
    var zipCode = "00000"
    let censusSurveyAPI = "acs5"
    let yearOfSurvey = "2014"
    let variablesToAdd = Array(CensusConstants.CENSUS_REQUEST_PARAMS.keys)
    let requestParameters = ["age",
                     "education_high_school",
                     "income_per_capita",
                     "median_contract_rent",
                     "employment_labor_force",
                     "population",
                     "commute_time_walked",
                     "poverty",
                     "employment_employed"]
    
    func getCitySDKData(completion: () -> ()) {
        cityAPI.sendAPIRequest(["level":self.levelOfLocationDetails, "zip":self.zipCode, "api":self.censusSurveyAPI, "year":self.yearOfSurvey, "variables":self.requestParameters]) { (cityData) in
            self.cityDataPoints = cityData
           // let score = ScoreModel(name: "Name", dataPoints: self.cityDataPoints[0].sendDataPoints())
            //self.scoreData = score
            completion()
        }
    }
    
    func getScoreModel(completion: () -> ()) {}
}