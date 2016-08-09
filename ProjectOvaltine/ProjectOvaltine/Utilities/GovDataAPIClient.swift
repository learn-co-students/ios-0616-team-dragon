//
//  GovDataAPIClient.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GovDataAPIClient {
   
    static let sharedInstance = GovDataAPIClient()
    let baseURL: String = " "
    let path: String = "/"
    let parameters = ["parameterOne": "Not implemented"]
    let variables = ["education_high_school", "income_per_capita", "median_contract_rent"]
    let key = Constants.GOVDATA_API_KEY
    
    
    //MARK request
    func sendAPIRequest() {
        
        guard NSURL(string:baseURL) != nil
            else {
                print("ERROR: Unable to get url path for API call")
                return
        }
        
        let url = NSURL(string: self.baseURL)
        
        let json = ["jsonParameterOne": "not implemented"]
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(self.key, forHTTPHeaderField: "Authorization")
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(json, options: [])
        
        Alamofire.request(request)
            .responseJSON { response in
                switch response.result {
                case .Success(let responseObject):
                    print(responseObject)
                default:
                    print("Error")
                }
        }
    }
}