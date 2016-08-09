
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
    let key = Constants.CITYSDK_API_KEY
    
    
    // MARK: Request
    func sendAPIRequest(params: NSDictionary, completion: ([CitySDKData]) -> ()) {
        
        guard self.baseURL != nil
            else {
                print("ERROR: Unable to get url path for API call")
                return
        }
        
        let url = NSURL(string: self.baseURL!)
        let request = NSMutableURLRequest(URL:url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(self.key, forHTTPHeaderField: "Authorization")
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        
        Alamofire.request(request).responseJSON { (response) in
            switch response.result {
                
            case .Success(let responseObject):
                
                var cityDataPoints: [CitySDKData] = []
                let response = responseObject as! NSDictionary
                
                if let feat = response["features"] as? NSArray {
                    let jsonProperties = JSON(feat[0]["properties"] as! NSDictionary)
                    let newData = CitySDKData(json: jsonProperties)
                    cityDataPoints.append(newData)
                    completion(cityDataPoints)
                }
                
            default:
                print("ERROR")
            }
        }
    }
}