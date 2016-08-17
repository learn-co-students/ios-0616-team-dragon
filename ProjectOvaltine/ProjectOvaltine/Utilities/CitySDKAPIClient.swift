
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

class CitySDKAPIClient {
    static let sharedInstance = CitySDKAPIClient()
    // MARK: Path Router
    enum URLRouter {
        static let baseURL: String = "http://citysdk.commerce.gov"
    }
    let baseURL: String = "http://citysdk.commerce.gov"
    let method: String = "POST"
    let URLPath: String = "/"
    let headers: Dictionary<String, String> = ["Not":"Implemented"]
    let parameters:Dictionary<String, String> = ["parameterOne": "not implemented"]
    let key = Constants.CITYSDK_API_KEY
    
    // MARK: Request
    func sendAPIRequest(params: NSDictionary, completion: ([CitySDKData]) -> ()) {
        guard let url = NSURL(string:URLRouter.baseURL)
            else {
                print("ERROR: Unable to get url path for API call")
                return
        }
        
        let request = NSMutableURLRequest(URL:url)
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
                    
                    if let geo = feat[0]["geometry"] as? NSDictionary {
                        
                        if let coords = geo["coordinates"] as? NSArray {
                            //                            print(coords[0].count)
                            //                            print(coords[0][0].count)
                            
                            
                            //This could probably be implemented better, but this fixes the bug where the app would crash if you were to query New York or California since they were nested differently.  It only checks for two cases, but I think it's the extent of the bug - if you find one let me know
                            if coords[0].count > 100 {
                                let newData = CitySDKData(json: jsonProperties, geoJSON: coords[0] as! NSArray)
                                cityDataPoints.append(newData)
                                
                            } else if coords[0][0].count > 100 {
                                
                                if let deeperCoords = coords[0][0] as? NSArray {
                                    let otherData = CitySDKData(json: jsonProperties, geoJSON: deeperCoords)
                                    cityDataPoints.append(otherData)
                                } else {
                                    print("error!")}
                            }
                            
                            
                            
                            
                            
                        }
                        
                        
                    }
                    
                    completion(cityDataPoints)
                }
            default:
                print("ERROR")
            }
        }
    }
    
    func sendTestAPIRequest(params: NSDictionary) {
        //code goes here
        //soon
    }
    
}