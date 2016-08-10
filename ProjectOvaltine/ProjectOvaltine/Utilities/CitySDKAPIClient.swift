
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
<<<<<<< HEAD
        let request = NSMutableURLRequest(URL:url)
=======
        
        let url = NSURL(string: self.baseURL!)
        

        let request = NSMutableURLRequest(URL:url!)
>>>>>>> 3e57809900705c9f6a9801d0bdd3667040fc7c95
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.setValue(self.key, forHTTPHeaderField: "Authorization")
        
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        
        Alamofire.request(request).responseJSON { (response) in
            switch response.result {

            case .Success(let responseObject):
                var cityDataPoints: [CitySDKData] = []
                let response = responseObject as! NSDictionary
<<<<<<< HEAD
=======
                if let geo = response["geometry"] as? NSArray {
                    print(geo)
                }
                if let feat = response["features"] as? NSArray {
                    let jsonProperties = JSON(feat[0]["properties"] as! NSDictionary)
                    let newData = CitySDKData(json: jsonProperties)
                    cityDataPoints.append(newData)
                    print(newData)
                    completion(cityDataPoints)
                }
            default:
                print("ERROR")
            }
        }
    }
>>>>>>> 3e57809900705c9f6a9801d0bdd3667040fc7c95
    
                if let feat = response["features"] as? NSArray {
<<<<<<< HEAD
                    let jsonProperties = JSON(feat[0]["properties"] as! NSDictionary)
                    
=======
                   
>>>>>>> 3e57809900705c9f6a9801d0bdd3667040fc7c95
                    if let geo = feat[0]["geometry"] as? NSDictionary {
                        
                        if let coords = geo["coordinates"] as? NSArray {
                            let newData = CitySDKData(json: jsonProperties, geoJSON:coords)
                            cityDataPoints.append(newData)
                        }
                    }
<<<<<<< HEAD
                    completion(cityDataPoints)
=======
                 
>>>>>>> 3e57809900705c9f6a9801d0bdd3667040fc7c95
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
//
//        guard let url = NSURL(string: self.baseURL)
//            else {
//                print("ERROR: Unable to get url path for API call")
//                return
//        }
//        let request = NSMutableURLRequest(URL:url)
//        request.HTTPMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue(self.key, forHTTPHeaderField: "Authorization")
//        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
//        
//        Alamofire.request(request).responseJSON { (response) in
//            switch response.result {
//            case .Success(let responseObject):
//                let response = responseObject as! NSDictionary
//                if let geo = response["geometry"] as? NSArray {
//                    print(geo)
//                }
//                if let feat = response["features"] as? NSArray {
//                    let jsonProperties = JSON(feat[0]["properties"] as! NSDictionary)
//                    if let geo = feat[0]["geometry"] as? NSDictionary {
//                        if let coords = geo["coordinates"] as? NSArray {
//                            for c in coords {
//                                print(c)
//                            }
//                        }
//                        
//                    }
//                }
//            default:
//                print("ERROR")
//            }
//        }
//    }
}