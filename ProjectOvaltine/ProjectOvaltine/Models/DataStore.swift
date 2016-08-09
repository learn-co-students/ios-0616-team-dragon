//
//  CitySDKDataStore.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation


class DataStore {
    static let sharedInstance = DataStore()
    
    let cityAPI = CitySDKAPIClient.sharedInstance
    let govDataAPI = GovDataAPIClient.sharedInstance
    let laborStatisticsAPI = LaborStatisticsAPIClient.sharedInstance
    let USAJobsAPI = USAJobsAPIClient.sharedInstance
    
    var cityDataPoints:[CitySDKData] = []
    var laborDataPoints:[LaborStatisticsData] = []
    var USAJobsDataPoints:[USAJobsData] = []
    
    let level = "county"
    let zip = "10001"
    let api = "acs5"
    let year = "2014"
    let variables = ["age",
                     "education_high_school",
                     "income_per_capita",
                     "median_contract_rent",
                     "employment_labor_force",
                     "population",
                     "commute_time_walked",
                     "poverty"]
    
    func getCitySDKData(completion: () -> ()) {
        cityAPI.sendAPIRequest(["level":level, "zip": zip, "api": api, "year": year, "variables": variables]) { (cityData) in
            print(cityData)
            self.cityDataPoints = cityData
            completion()
        }
    }
    
    func sendCityAPITest() {
        cityAPI.sendTestAPIRequest(["level":level, "zip": zip, "api": api, "year": year, "variables": variables])
    }
    
    func getUSAJobsData() {
        govDataAPI.sendAPIRequest()
        
    }
    
    func getLaborStatisticsData() {
        laborStatisticsAPI.sendAPIRequest()
    }
}