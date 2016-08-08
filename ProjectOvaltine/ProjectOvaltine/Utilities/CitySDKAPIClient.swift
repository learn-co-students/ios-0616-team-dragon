//
//  CitySDKAPIClient.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CitySDKAPIClient: Request {
    
    static let sharedInstance = CitySDKAPIClient()
    
    // MARK: Path Router
    let baseURL: String? = "http://citysdk.commerce.gov"
    let path: String? = "/"
    
    let parameters = ["parameterOne": "not implemented"]
    let variables = ["education_high_school", "income_per_capita", "median_contract_rent", "employment_labor_force"]
    let key = Constants.CITYSDK_API_KEY
    
    
    
    //func searchForRepository(name: String, completion: ([GithubRepository]) -> ())
  
    // MARK: Request
    func sendAPIRequest(level: String, zip: String, api: String, year: String, completion: ([CitySDKData]) -> ()) {
        guard self.baseURL != nil
            else {
                print("ERROR: Unable to get url path for API call")
                return
        }
        //"age" "income" "commute_time_walked" "population" B17001_002E  "poverty", "income_per_capita",
        let url = NSURL(string: self.baseURL!)
        let request = NSMutableURLRequest(URL:url!)
        request.HTTPMethod = "POST" 
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json = ["level" : level,
                    "zip" : zip,
                    "variables" : self.variables,
                    "api": api,
                    "year": year]
        request.setValue(self.key, forHTTPHeaderField: "Authorization")
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(json, options: [])
        Alamofire.request(request).responseJSON { (response) in
            switch response.result {
                case .Success(let responseObject):
                    var cityDataPoints: [CitySDKData] = []
                    let response = responseObject as! NSDictionary
                    if let feat = response["features"] as? NSArray {
                        if let jsonProperties = feat[0]["properties"] as? JSON {
                            cityDataPoints.append(CitySDKData(json: jsonProperties))
                        }
                        completion(cityDataPoints)
                    }
                default:
                    print("ERROR")
                }

        }
    }

}