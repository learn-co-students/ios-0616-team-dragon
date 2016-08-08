//
//  CitySDKAPIClient.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import Alamofire

class CitySDKAPIClient: Request {
    
    // MARK: Path Router
    let baseURL: String = "http://citysdk.commerce.gov"
    let method = "post"
    let path: String = "/"
    
    let parameters = ["parameterOne": "not implemented"]
    let key = Constants.CITYSDK_API_KEY
    
    // MARK: Request
    func sendAPIRequest() {
        
//        guard let urlString = self.baseURL + self.path
//            else { print("ERROR: Unable to get url path for API call")
//        }
        
        let request = NSMutableURLRequest(URL: NSURL(fileURLWithPath: baseURL))
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let values = [
            "zip": "21401",
            "state": "MD",
            "level": "state",
            "sublevel": "False",
            "api": "acs5",
            "year": 2010,
            "variables": ["income", "population"]
            ]
        
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(values, options: [])

        Alamofire.request(request)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .Success(let responseObject):
                    print(responseObject)
                default:
                    print("ERROR")
                }

        }
    }
    
}