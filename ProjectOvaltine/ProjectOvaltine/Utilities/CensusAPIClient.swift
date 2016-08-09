//
//  CensusAPIClient.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/9/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CensusAPIClient {
    static let sharedInstance = CensusAPIClient()
    
    let baseURL: String? = "http://api.census.gov/data/2014/"
    
    
    let commuteTimePublicTransport = "B08136_007E"
    let commuteTime = "B08136_001E"
    let commuteTimeWalked = "B08136_011E"
    let educationBachelors = "B15003_022E"
    let educationHighSchool = "B15003_017E"
    let educationNone = "B15003_002E"
    let educationProfessional = "B15003_024E"
    let employmentCivilianLaborForce = "B23025_003E"
    let employmentEmployed = "B23025_004E"
    let employmentLaborForce = "B23025_002E"
    let employmentNotLaborForce = "B23025_007E"
    let employmentUnemployed = "B23025_005E"
    let income = "B19013_001E"
    let incomePerCapita = "B19301_001E"
    let medianContractRent = "B25058_001E"
    let medianFemaleAge = "B01002_003E"
    let medianGrossRent = "B25064_001E"
    let medianHomeValue = "B25077_001E"
    let medianHouseConstructionYear = "B25035_001E"
    let medianMaleAge = "B01002_002E"
    let population = "B01003_001E"
    let poverty = "B17001_002E"
    let povertyFamily = "B17012_002E"
    let povertyFamilyMarried = "B17012_003E"
    let povertyFamilySingleFemale = "B17012_014E"
    let povertyFamilySingleMale = "B17012_009E"
    let povertyFemale = "B17001_017E"
    let povertyMale = "B17001_003E"
    let tenToNineteen = "B25032C_007E"
    let sameHouseOneYear = "B07012_005E"
    let belowOneHundredPercentPovertyLine = "B07012_002E"
    let twentyFiveToTwentyNine = "B07401_006E"
    let twentyToTwentyFour = "B07401_005E"
    let workedAtHome = "B08505A_007E"
    let medianIncomeForeignBorn = "B06011_005E" //past 12 months
    let twentyToFortyNine = "B25024_008E"
    let totalLivingInAreaOneYearAgo = "B07401_001E"
    let zip = "10004"
    
    
    
    func sendAPIRequest() {
        guard baseURL != nil
            else { print("ERROR: Unable to get url path for API call")
            return
        }
        
        let path: String? = "acs5?get=\(commuteTimePublicTransport),\(commuteTime),\(commuteTimeWalked),\(educationBachelors),\(educationHighSchool),\(educationNone),\(educationProfessional),\(employmentCivilianLaborForce),\(employmentEmployed),\(employmentLaborForce),\(employmentNotLaborForce),\(employmentUnemployed),\(income),\(incomePerCapita),\(medianContractRent),\(medianFemaleAge),\(medianGrossRent),\(medianHomeValue),\(medianHouseConstructionYear),\(medianMaleAge),\(population),\(poverty),\(povertyFamily),\(povertyFamilyMarried),\(povertyFamilySingleFemale),\(povertyFamilySingleMale),\(povertyMale),\(povertyFemale),\(tenToNineteen),\(sameHouseOneYear),\(belowOneHundredPercentPovertyLine),\(twentyFiveToTwentyNine),\(twentyToTwentyFour),\(workedAtHome),\(medianIncomeForeignBorn),\(twentyToFortyNine),\(totalLivingInAreaOneYearAgo)&for=zip+code+tabulation+area:\(zip)"
        
        print(path)
        
        let url = NSURL(string: self.baseURL! + path!)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        
        Alamofire.request(request).responseJSON { (response) in
            switch response.result {
            case .Success(let responseObject):
                print(responseObject)
            default:
                print("ERROR")
            }
        }
    }
    
}