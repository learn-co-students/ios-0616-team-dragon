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
    let variables = ["age",
                     "education_high_school",
                     "income_per_capita",
                     "median_contract_rent",
                     "employment_labor_force",
                     "population",
                     "commute_time_walked",
                     "poverty"]
    let key = Constants.CITYSDK_API_KEY
    
    
    // MARK: Request
    func sendAPIRequest(level: String, zip: String, api: String, year: String, completion: ([CitySDKData]) -> ()) {
        
        guard self.baseURL != nil
            else {
                print("ERROR: Unable to get url path for API call")
                return
        }
        
        let url = NSURL(string: self.baseURL!)
        let request = NSMutableURLRequest(URL:url!)
        
        request.HTTPMethod = "POST" 
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let json = ["level" : "county",
                    "zip" : "08540",
                    "variables" :[ "age" ],
                    "api":"acs5",
                    "year":"2014"]

        request.setValue(self.key, forHTTPHeaderField: "Authorization")
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(json, options: [])
        
        Alamofire.request(request).responseJSON { (response) in
            switch response.result {
                case .Success(let responseObject):
                    var cityDataPoints: [CitySDKData] = []
                    let response = responseObject as! NSDictionary
                    //print("response \(response)")
                    if let feat = response["features"] as? NSArray {
                        //print("feat \(feat[0]["properties"])")
                        let jsonProperties = JSON(feat[0]["properties"] as! NSDictionary)
                        //print(jsonProperties["B01002_001E"])
                        let newData = CitySDKData(json: jsonProperties)
                        //print(newData)
                        cityDataPoints.append(newData)
                            //print("jsonProperties \(jsonProperties)")
                            //print("city data points \(cityDataPoints)")
                        
                        completion(cityDataPoints)
                    }
                default:
                    print("ERROR")
                }
        }
    }
}

