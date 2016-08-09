//
//  USAJobsAPIClient.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import Alamofire

class USAJobsAPIClient {
    
    static let sharedInstance = USAJobsAPIClient()
    
    let baseURL: String? = "https://data.usajobs.gov/api/search"
    let path: String? = "?JobCategoryCode=2210"
    let parameters = ["parameterOne":"not implemented"]
    let variables = ["education_high_school", "income_per_capita", "median_contract_rent"]
    let key = Constants.USAJOBS_API_KEY
    let email = Constants.USAJOBS_USER_AGENT
    
    
    //MARK request 
    func sendAPIRequest() {
        
        guard self.baseURL != nil
            else {
                print("ERROR: Unable to get url path for API call")
                return 
        }
        
        let url = NSURL(string: self.baseURL! + self.path!)
        let request = NSMutableURLRequest(URL:url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let params = ["not":"implemented"]
        request.setValue(self.key, forHTTPHeaderField: "Authorization-Key")
        request.setValue(self.email, forHTTPHeaderField: "User-Agent")
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        
        Alamofire.request(request)
            .responseJSON { response in
                print(response.response)
            }
    }
    
}
